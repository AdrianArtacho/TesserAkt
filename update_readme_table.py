#!/usr/bin/env python3
"""
Rebuild the submodule table in README.md.

- Reads .gitmodules to discover submodules (path + url).
- For each submodule:
  * Name = directory name
  * Link = URL from .gitmodules (if present), otherwise plain text name
  * Description = first meaningful line from submodule's README.md
  * Preview = <img src="submodule/img/gui.png" width="140"> if present, otherwise "–"
- Produces a 3‑column Markdown table: Name | Description | Preview
- Replacement strategy (in order of preference):
  1) If README contains markers <!-- BEGIN: SUBMODULE_TABLE --> ... <!-- END: SUBMODULE_TABLE -->
     replace only that block.
  2) Else, if README contains a table whose header line starts with "| Name" and includes "Description",
     replace that entire contiguous table block.
  3) Else, insert the table under a "## Submodules" section (create the section if absent).

Run from repo root:  python update_readme_table.py
"""

from __future__ import annotations
import os
import re
from pathlib import Path
from typing import List, Tuple, Optional

ROOT = Path(__file__).resolve().parent
README = ROOT / "README.md"
GITMODULES = ROOT / ".gitmodules"

MARKER_BEGIN = "<!-- BEGIN: SUBMODULE_TABLE -->"
MARKER_END   = "<!-- END: SUBMODULE_TABLE -->"

IMG_RELATIVE = "img/gui.png"

def parse_gitmodules(path: Path) -> List[Tuple[str, Optional[str]]]:
    if not path.exists():
        return []
    subs: List[Tuple[str, Optional[str]]] = []
    cur_path = None
    cur_url  = None
    for raw in path.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = raw.strip()
        if line.startswith("[submodule"):
            if cur_path is not None:
                subs.append((cur_path, cur_url))
            cur_path = None
            cur_url  = None
        elif line.startswith("path"):
            _, val = line.split("=", 1)
            cur_path = val.strip()
        elif line.startswith("url"):
            _, val = line.split("=", 1)
            cur_url = val.strip()
    if cur_path is not None:
        subs.append((cur_path, cur_url))
    return subs

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
    # If first non-empty is a header, try next content line; strip markdown hash
    if lines[i].lstrip().startswith("#"):
        title = lines[i].lstrip("#").strip()
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines) and not lines[j].lstrip().startswith("#"):
            return lines[j].strip()
        return title or "_No description available._"
    return lines[i].strip()

def cell_escape(text: str) -> str:
    # Escape pipes to avoid breaking the table
    return text.replace("|", r"\|")

def build_table() -> str:
    subs = parse_gitmodules(GITMODULES)
    # Sort by submodule directory name for stability
    subs = sorted(subs, key=lambda t: Path(t[0]).name.lower())
    rows = []
    for rel_path, url in subs:
        sub_path = (ROOT / rel_path).resolve()
        name = sub_path.name
        # Name cell with link if URL present
        if url:
            name_cell = f"[{name}]({url})"
        else:
            name_cell = name
        # Description
        desc = first_description_line(sub_path / "README.md")
        desc_cell = cell_escape(desc)
        # Preview image if present
        img_path = sub_path / IMG_RELATIVE
        if img_path.exists():
            src = os.path.relpath(img_path, start=ROOT)
            preview_cell = f'<img src="{src}" width="140" alt="{name} GUI">'
        else:
            preview_cell = "–"
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
    # Find a contiguous block that starts with a header row beginning with "| Name"
    pattern = re.compile(
        r"(^\|[^\n]*Name[^\n]*\n\|[^\n]*\n(?:\|[^\n]*\n)+)",
        flags=re.MULTILINE
    )
    if pattern.search(text):
        return pattern.sub(table_md + "\n", text, count=1)
    return None

def ensure_submodules_section(text: str, table_md: str) -> str:
    # If there's a "## Submodules" section, insert/replace the table under it.
    subsec_pat = re.compile(r"^##\s+Submodules\s*$", flags=re.MULTILINE)
    m = subsec_pat.search(text)
    block = f"{MARKER_BEGIN}\n{table_md}\n{MARKER_END}\n"
    if m:
        # Find where the section content ends (next '## ' or end of file)
        start = m.end()
        next_sec = re.search(r"^##\s+", text[start:], flags=re.MULTILINE)
        if next_sec:
            end = start + next_sec.start()
        else:
            end = len(text)
        # Replace section content with our block
        before = text[:start]
        # Keep a leading newline
        after = text[end:]
        # Remove any existing content directly following the header up to end
        return before + "\n" + block + ("\n" if not after.startswith("\n") else "") + after
    else:
        # Append a new Submodules section at the end
        sep = "" if text.endswith("\n") else "\n"
        return f"{text}{sep}\n\n## Submodules\n\n{block}\n"

def main():
    table_md = build_table()
    if not README.exists():
        README.write_text(f"## Submodules\n\n{MARKER_BEGIN}\n{table_md}\n{MARKER_END}\n", encoding="utf-8")
        print("✅ README created with submodule table.")
        return
    text = README.read_text(encoding="utf-8", errors="ignore")
    # 1) Marker replacement
    updated = replace_with_markers(text, table_md)
    if updated is None:
        # 2) Replace first table starting with | Name ... header
        updated = replace_existing_table(text, table_md)
    if updated is None:
        # 3) Ensure a Submodules section and insert the table block
        updated = ensure_submodules_section(text, table_md)
    README.write_text(updated, encoding="utf-8")
    print("✅ Submodule table updated.")

if __name__ == "__main__":
    main()
