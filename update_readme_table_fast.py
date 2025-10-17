#!/usr/bin/env python3
"""
Fast submodule table updater (no network calls).

- Never calls out to 'git ls-remote' or fetches anything.
- For GitHub/GitLab submodules, uses a moving ref 'HEAD' directly in the raw URL.
- For other hosts (Bitbucket/self-hosted), we **skip** the image to avoid network delays; cell stays empty "–".
- If img/gui.png is missing in a submodule, we skip the preview for that row.
- Rewrites a 3-column table (Name | Description | Preview) under markers or '## Submodules'.

Run: python update_readme_table_fast.py
"""

from __future__ import annotations
import os
import re
from pathlib import Path
from typing import List, Tuple, Optional, Dict

ROOT = Path(__file__).resolve().parent
README = ROOT / "README.md"
GITMODULES = ROOT / ".gitmodules"

MARKER_BEGIN = "<!-- BEGIN: SUBMODULE_TABLE -->"
MARKER_END   = "<!-- END: SUBMODULE_TABLE -->"

IMG_RELATIVE = "img/gui.png"

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
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines) and not lines[j].lstrip().startswith("#"):
            return lines[j].strip()
        return lines[i].lstrip("#").strip() or "_No description available._"
    return lines[i].strip()

def cell_escape(text: str) -> str:
    return text.replace("|", r"\|")

def raw_url_head(host: str, owner: str, repo: str) -> Optional[str]:
    # Only emit URLs for hosts we know will accept HEAD without an extra lookup.
    if "github.com" in host or host.endswith("github.com"):
        return f"https://raw.githubusercontent.com/{owner}/{repo}/HEAD/{IMG_RELATIVE}"
    if "gitlab.com" in host:
        return f"https://gitlab.com/{owner}/{repo}/-/raw/HEAD/{IMG_RELATIVE}"
    # Unknown/Bitbucket/self-hosted => skip image to avoid network/branch detection
    return None

def build_table() -> str:
    subs = parse_gitmodules(GITMODULES)
    subs = sorted(subs, key=lambda d: Path(d["path"]).name.lower())
    rows = []
    for sm in subs:
        rel_path = sm["path"]
        url      = sm.get("url") or ""
        sub_path = (ROOT / rel_path).resolve()
        name     = sub_path.name

        # Name cell
        name_cell = f"[{name}]({url})" if url else name

        # Description from local README inside submodule (fast, offline)
        desc = first_description_line(sub_path / "README.md")
        desc_cell = cell_escape(desc)

        # Preview: only if img/gui.png exists **in the submodule repo** and we can build a no-lookup raw URL
        preview_cell = "–"
        img_local_path = sub_path / IMG_RELATIVE
        if img_local_path.exists() and url:
            info = normalize_repo(url)
            if info:
                raw = raw_url_head(info["host"], info["owner"], info["repo"])
                if raw:
                    preview_cell = f'<img src="{raw}" width="140" alt="{name} GUI">'

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
        print("✅ README created with submodule table (fast, no network).")
        return
    text = README.read_text(encoding="utf-8", errors="ignore")
    updated = replace_with_markers(text, table_md)
    if updated is None:
        updated = replace_existing_table(text, table_md)
    if updated is None:
        updated = ensure_submodules_section(text, table_md)
    README.write_text(updated, encoding="utf-8")
    print("✅ Submodule table updated (fast, no network).")

if __name__ == "__main__":
    main()
