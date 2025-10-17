#!/usr/bin/env python3
"""
Update README submodule table with image previews that always point at the latest version.

What changed vs. previous script:
- We now construct image URLs using a *moving ref*:
  * GitHub & GitLab: use "HEAD" directly (their raw endpoints resolve HEAD to the default branch's latest commit).
  * Bitbucket: resolve the remote's default branch via `git ls-remote --symref <url> HEAD`,
               fall back to .gitmodules' "branch" if present, otherwise try "main" then "master".

Why: using HEAD/default-branch means the README always shows the newest GUI image without
needing to update the superproject's recorded submodule commit.

Run from repo root:  python update_readme_table_head.py
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

def normalize_repo(url: str) -> Optional[Dict[str, str]]:
    if not url:
        return None
    u = url.strip()
    if u.endswith(".git"):
        u = u[:-4]
    m = re.match(r"^git@([^:]+):([^/]+)/(.+)$", u)  # ssh
    if m:
        host, owner, repo = m.group(1), m.group(2), m.group(3)
        return {"host": host.lower(), "owner": owner, "repo": repo}
    m = re.match(r"^https?://([^/]+)/([^/]+)/(.+)$", u)  # https
    if m:
        host, owner, repo = m.group(1), m.group(2), m.group(3)
        return {"host": host.lower(), "owner": owner, "repo": repo}
    return None

def default_branch_from_remote(url: str) -> Optional[str]:
    """
    Ask the remote which branch HEAD points to:
      git ls-remote --symref <url> HEAD
    Output example:
      ref: refs/heads/main HEAD
      <sha>  HEAD
    """
    try:
        out = sh(["git", "ls-remote", "--symref", url, "HEAD"])
    except Exception:
        return None
    for line in out.splitlines():
        line = line.strip()
        if line.startswith("ref:") and "refs/heads/" in line:
            # ref: refs/heads/main HEAD
            m = re.search(r"refs/heads/([^\s]+)", line)
            if m:
                return m.group(1)
    return None

def raw_image_url(info: Dict[str,str], moving_ref: str) -> Optional[str]:
    host = info["host"]
    owner = info["owner"]
    repo  = info["repo"]
    path  = IMG_RELATIVE
    if "github.com" in host or host.endswith("github.com"):
        # raw.githubusercontent supports HEAD as a ref
        return f"https://raw.githubusercontent.com/{owner}/{repo}/{moving_ref}/{path}"
    if "bitbucket.org" in host:
        # Bitbucket raw endpoint accepts branch names
        return f"https://bitbucket.org/{owner}/{repo}/raw/{moving_ref}/{path}"
    if "gitlab.com" in host:
        # GitLab supports HEAD and branch names at -/raw/<ref>/path
        return f"https://gitlab.com/{owner}/{repo}/-/raw/{moving_ref}/{path}"
    return None

def first_description_line(readme_path: Path) -> str:
    if not readme_path.exists():
        return "_No README found._"
    lines = readme_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    # Skip empties
    i = 0
    while i < len(lines) and not lines[i].strip():
        i += 1
    if i >= len(lines):
        return "_No description available._"
    # If first non-empty is a header, try next non-header
    if lines[i].lstrip().startswith("#"):
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines) and not lines[j].lstrip().startswith("#"):
            return lines[j].strip()
        return lines[i].lstrip("#").strip() or "_No description available._"
    return lines[i].strip()

def cell_escape(text: str) -> str:
    return text.replace("|", r"\|")

def resolve_moving_ref(url: str, branch_hint: Optional[str]) -> str:
    info = normalize_repo(url) if url else None
    if not info:
        return "HEAD"  # harmless default for GH/GL; ignored otherwise
    host = info["host"]
    # GitHub/GitLab can use HEAD
    if "github.com" in host or host.endswith("github.com") or "gitlab.com" in host:
        return "HEAD"
    # Bitbucket: try remote HEAD -> branch_hint -> main -> master
    # (ls-remote works for GitHub/GitLab too, but this keeps it fast)
    default = default_branch_from_remote(url)
    if default:
        return default
    if branch_hint:
        return branch_hint
    # Common fallbacks
    for cand in ("main", "master", "default"):
        return cand
    return "main"

def build_table() -> str:
    subs = parse_gitmodules(GITMODULES)
    subs = sorted(subs, key=lambda d: Path(d["path"]).name.lower())
    rows = []
    for sm in subs:
        rel_path = sm["path"]
        url      = sm.get("url") or ""
        branch   = sm.get("branch")
        sub_path = (ROOT / rel_path).resolve()
        name     = sub_path.name
        # Name cell
        name_cell = f"[{name}]({url})" if url else name
        # Description
        desc = first_description_line(sub_path / "README.md")
        desc_cell = cell_escape(desc)
        # Preview using moving ref (HEAD/default-branch)
        preview_cell = "–"
        info = normalize_repo(url) if url else None
        if info:
            moving_ref = resolve_moving_ref(url, branch)
            raw_url = raw_image_url(info, moving_ref)
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
        print("✅ README created with submodule table (moving HEAD/branch URLs).")
        return
    text = README.read_text(encoding="utf-8", errors="ignore")
    updated = replace_with_markers(text, table_md)
    if updated is None:
        updated = replace_existing_table(text, table_md)
    if updated is None:
        updated = ensure_submodules_section(text, table_md)
    README.write_text(updated, encoding="utf-8")
    print("✅ Submodule table updated (moving HEAD/branch URLs).")

if __name__ == "__main__":
    main()
