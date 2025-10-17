#!/usr/bin/env python3
"""
Update README submodule table with image previews that also render on GitHub.

Why this exists:
- In a meta-repo, submodules are separate repos. Relative paths like
  "subA/img/gui.png" won't render on GitHub because those files aren't in the
  meta-repo tree. We therefore build absolute *raw* URLs to the image file
  in each submodule, pinned to the submodule commit tracked by the superproject.

What it does:
- Parse .gitmodules for (path, url[, branch]).
- Get the tracked commit SHA for each submodule via `git ls-tree HEAD <path>`.
- Generate raw image URLs per host:
    * GitHub:    https://raw.githubusercontent.com/<owner>/<repo>/<sha>/img/gui.png
      (fallback: https://github.com/<owner>/<repo>/blob/<sha>/img/gui.png?raw=1)
    * Bitbucket: https://bitbucket.org/<owner>/<repo>/raw/<sha>/img/gui.png
    * GitLab:    https://gitlab.com/<owner>/<repo>/-/raw/<sha>/img/gui.png
  If we can't normalize the host, we skip the image (show "–").
- Build a 3-column table: Name | Description | Preview
- Replacement order: marker block, existing Name-table, or under "## Submodules".

Run from repo root:  python update_readme_table_raw.py
"""

from __future__ import annotations
import os
import re
import subprocess
from pathlib import Path
from typing import List, Tuple, Optional, Dict

ROOT = Path(__file__).resolve().parent
README = ROOT / "README.md"
GITMODULES = ROOT / ".gitmodules"

MARKER_BEGIN = "<!-- BEGIN: SUBMODULE_TABLE -->"
MARKER_END   = "<!-- END: SUBMODULE_TABLE -->"

IMG_RELATIVE = "img/gui.png"

def sh(cmd: List[str], cwd: Optional[Path] = None) -> str:
    return subprocess.check_output(cmd, cwd=str(cwd or ROOT)).decode("utf-8", "replace").strip()

def parse_gitmodules(path: Path) -> List[Dict[str, Optional[str]]]:
    items: List[Dict[str, Optional[str]]] = []
    if not path.exists():
        return items
    current: Dict[str, Optional[str]] = {}
    for raw in path.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = raw.strip()
        if line.startswith("[submodule"):
            if current:
                items.append(current)
            current = {"path": None, "url": None, "branch": None}
        elif "=" in line:
            key, val = [s.strip() for s in line.split("=", 1)]
            if key in ("path", "url", "branch"):
                current[key] = val
    if current:
        items.append(current)
    return [x for x in items if x.get("path")]

def get_submodule_sha(path: str) -> Optional[str]:
    try:
        # git ls-tree HEAD path -> "... <type> <sha>\tpath"
        out = sh(["git", "ls-tree", "HEAD", path])
        # Find the third field (sha)
        # Example: "160000 commit 0123456789abcdef...    subdir"
        parts = out.split()
        for i, tok in enumerate(parts):
            if tok in ("commit", "blob", "tree") and i + 1 < len(parts):
                return parts[i+1]
        # Fallback: try 'git rev-parse HEAD:./path'
        out = sh(["git", "rev-parse", f"HEAD:{path}"])
        return out.strip() or None
    except Exception:
        return None

def normalize_repo(url: str) -> Optional[Dict[str, str]]:
    """
    Return dict with host, owner, repo for GitHub/GitLab/Bitbucket URLs.
    Supports https and ssh urls.
    """
    if not url:
        return None
    u = url.strip()
    # Remove trailing .git
    if u.endswith(".git"):
        u = u[:-4]
    # ssh forms:
    # git@github.com:owner/repo
    m = re.match(r"^git@([^:]+):([^/]+)/(.+)$", u)
    if m:
        host, owner, repo = m.group(1), m.group(2), m.group(3)
        return {"host": host.lower(), "owner": owner, "repo": repo}
    # https forms:
    m = re.match(r"^https?://([^/]+)/([^/]+)/(.+)$", u)
    if m:
        host, owner, repo = m.group(1), m.group(2), m.group(3)
        return {"host": host.lower(), "owner": owner, "repo": repo}
    return None

def raw_image_url(info: Dict[str,str], ref: str) -> Optional[str]:
    host = info["host"]
    owner = info["owner"]
    repo  = info["repo"]
    path  = IMG_RELATIVE
    if "github.com" in host or host.endswith("github.com"):
        # Prefer raw.githubusercontent pinned to sha
        return f"https://raw.githubusercontent.com/{owner}/{repo}/{ref}/{path}"
    if "bitbucket.org" in host:
        return f"https://bitbucket.org/{owner}/{repo}/raw/{ref}/{path}"
    if "gitlab.com" in host:
        return f"https://gitlab.com/{owner}/{repo}/-/raw/{ref}/{path}"
    # Unknown host
    return None

def first_description_line(readme_path: Path) -> str:
    if not readme_path.exists():
        return "_No README found._"
    lines = readme_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    i = 0
    while i < len(lines) and not lines[i].strip():
        i += 1
    if i >= len(lines):
        return "_No description available._"
    if lines[i].lstrip().startswith("#"):
        # Skip title, use next non-empty non-header line if present
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines) and not lines[j].lstrip().startswith("#"):
            return lines[j].strip()
        return lines[i].lstrip("#").strip() or "_No description available._"
    return lines[i].strip()

def cell_escape(text: str) -> str:
    return text.replace("|", r"\|")

def build_table() -> str:
    subs = parse_gitmodules(GITMODULES)
    subs = sorted(subs, key=lambda d: Path(d["path"]).name.lower())
    rows = []
    for sm in subs:
        rel_path = sm["path"]
        url      = sm.get("url") or ""
        branch   = sm.get("branch") or ""
        sub_path = (ROOT / rel_path).resolve()
        name     = sub_path.name
        # Name cell
        name_cell = f"[{name}]({url})" if url else name
        # Description
        desc = first_description_line(sub_path / "README.md")
        desc_cell = cell_escape(desc)
        # Image via raw URL pinned to submodule SHA
        preview_cell = "–"
        if url:
            info = normalize_repo(url)
            sha = get_submodule_sha(rel_path)
            ref = sha or branch or "main"
            if info:
                raw_url = raw_image_url(info, ref)
                if raw_url:
                    preview_cell = f'<img src="{raw_url}" width="140" alt="{name} GUI">'
        rows.append(f"| {name_cell} | {desc_cell} | {preview_cell} |")
    header = "| Name | Description | Preview |\n| --- | --- | :---: |"
    return "\n".join([header] + rows) if rows else (header + "\n| – | _No submodules found._ | – |")

def replace_with_markers(text: str, table_md: str) -> Optional[str]:
    if MARKER_BEGIN in text and MARKER_END in text:
        return re.sub(
            rf"{re.escape(MARKER_BEGIN)}[\s\S]*?{re.escape(MARKER_END)}",
            f"{MARKER_BEGIN}\n{table_md}\n{MARKER_END}",
            text,
            flags=re.MULTILINE
        )
    return None

def replace_existing_table(text: str, table_md: str) -> Optional[str]:
    pattern = re.compile(r"(^\|[^\n]*Name[^\n]*\n\|[^\n]*\n(?:\|[^\n]*\n)+)", flags=re.MULTILINE)
    if pattern.search(text):
        return pattern.sub(table_md + "\n", text, count=1)
    return None

def ensure_submodules_section(text: str, table_md: str) -> str:
    subsec_pat = re.compile(r"^##\s+Submodules\s*$", flags=re.MULTILINE)
    m = subsec_pat.search(text)
    block = f"{MARKER_BEGIN}\n{table_md}\n{MARKER_END}\n"
    if m:
        start = m.end()
        next_sec = re.search(r"^##\s+", text[start:], flags=re.MULTILINE)
        end = start + next_sec.start() if next_sec else len(text)
        before, after = text[:start], text[end:]
        return before + "\n" + block + ("\n" if not after.startswith("\n") else "") + after
    else:
        sep = "" if text.endswith("\n") else "\n"
        return f"{text}{sep}\n\n## Submodules\n\n{block}\n"

def main():
    table_md = build_table()
    if not README.exists():
        README.write_text(f"## Submodules\n\n{MARKER_BEGIN}\n{table_md}\n{MARKER_END}\n", encoding="utf-8")
        print("✅ README created with submodule table (raw image URLs).")
        return
    text = README.read_text(encoding="utf-8", errors="ignore")
    updated = replace_with_markers(text, table_md)
    if updated is None:
        updated = replace_existing_table(text, table_md)
    if updated is None:
        updated = ensure_submodules_section(text, table_md)
    README.write_text(updated, encoding="utf-8")
    print("✅ Submodule table updated (raw image URLs).")

if __name__ == "__main__":
    main()
