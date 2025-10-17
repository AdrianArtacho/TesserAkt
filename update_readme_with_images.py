#!/usr/bin/env python3
"""
Update the repo's README by (re)generating a "## Submodules" section that lists all git submodules,
optionally embedding a small GUI image from each submodule if available at "img/gui.png".

- Submodules are discovered from .gitmodules (preferred). If .gitmodules is missing, we fall back to scanning
  immediate child directories that contain a .git folder/file (best effort).
- For each submodule, we try to extract a short description from its README.md (first non-empty line after the title).
- For each submodule, if img/gui.png exists, we embed it as a 150px-wide image using inline HTML
  (works well on GitHub). Otherwise, we write a placeholder note.
- The generated section replaces any existing content between "## Submodules" and the next "## " header.

Run from the repository root: `python update_readme_with_images.py`
"""

from __future__ import annotations
import os
import re
from pathlib import Path
from typing import List, Tuple, Optional

ROOT = Path(__file__).resolve().parent
README = ROOT / "README.md"
GITMODULES = ROOT / ".gitmodules"
SECTION_HEADER = "## Submodules"
IMG_RELATIVE = "img/gui.png"  # inside each submodule

def parse_gitmodules(path: Path) -> List[Tuple[str, Optional[str]]]:
    """
    Parse .gitmodules and return a list of (submodule_path, url_or_none).
    """
    if not path.exists():
        return []
    submodules: List[Tuple[str, Optional[str]]] = []
    current_path = None
    current_url = None
    for raw in path.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = raw.strip()
        if line.startswith("[submodule"):
            if current_path is not None:
                submodules.append((current_path, current_url))
            current_path = None
            current_url = None
        elif line.startswith("path"):
            _, val = line.split("=", 1)
            current_path = val.strip()
        elif line.startswith("url"):
            _, val = line.split("=", 1)
            current_url = val.strip()
    if current_path is not None:
        submodules.append((current_path, current_url))
    return submodules

def fallback_find_submodules(root: Path) -> List[Tuple[str, Optional[str]]]:
    """
    Fallback: treat any immediate child dir with a .git directory/file as a submodule-like project.
    URL unknown -> None.
    """
    results: List[Tuple[str, Optional[str]]] = []
    for child in sorted(root.iterdir()):
        if not child.is_dir():
            continue
        if child.name.startswith("."):
            continue
        git_dir = child / ".git"
        if git_dir.exists():
            results.append((child.name, None))
    return results

def first_description_line(readme_path: Path) -> str:
    """
    Extract a concise description from README.md:
    - prefer the first non-empty line that is not a top-level title line OR
    - if only a title exists, return the title line text without hashes
    - fallback text if nothing usable
    """
    if not readme_path.exists():
        return "_No README found._"
    lines = readme_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    # strip leading empties
    i = 0
    while i < len(lines) and not lines[i].strip():
        i += 1
    if i >= len(lines):
        return "_No description available._"
    # If first non-empty is a header, keep looking for the next non-empty non-header
    if lines[i].lstrip().startswith("#"):
        title_candidate = lines[i].lstrip("#").strip()
        j = i + 1
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines) and not lines[j].lstrip().startswith("#"):
            return lines[j].strip()
        return title_candidate or "_No description available._"
    return lines[i].strip()

def build_entry(name: str, rel_path: str, url: Optional[str], description: str) -> str:
    """
    Build the markdown block for a single submodule.
    Use inline HTML for image width control on GitHub.
    """
    parts = [f"### {name}"]
    if url:
        parts.append(f"*Repository:* [{url}]({url})")
    img_rel = Path(rel_path) / IMG_RELATIVE
    if img_rel.exists():
        # make path relative to repo root README
        img_src = os.path.relpath(img_rel, start=ROOT)
        parts.append(f'<img src="{img_src}" width="150" alt="{name} GUI">')
    else:
        parts.append("_No GUI preview available._")
    if description:
        parts.append("")
        parts.append(description)
    parts.append("\n---")
    return "\n".join(parts)

def generate_section() -> str:
    # Discover submodules
    subs = parse_gitmodules(GITMODULES)
    if not subs:
        subs = fallback_find_submodules(ROOT)

    entries = []
    for rel_path, url in subs:
        sub_path = (ROOT / rel_path).resolve()
        name = sub_path.name
        readme = sub_path / "README.md"
        desc = first_description_line(readme)
        entries.append(build_entry(name, str(sub_path), url, desc))

    header = SECTION_HEADER
    body = "\n\n".join(entries) if entries else "_No submodules found._"
    return f"{header}\n\n{body}\n"

def replace_section_in_readme(readme_text: str, new_section: str) -> str:
    """
    Replace existing section that starts with '## Submodules' and goes up to the next '## ' or end.
    If not present, append at the end with two newlines.
    """
    pattern = re.compile(rf"^{re.escape(SECTION_HEADER)}[\s\S]*?(?=^\#\#\s|\Z)", re.MULTILINE)
    if pattern.search(readme_text):
        return pattern.sub(new_section, readme_text)
    # If README ends without newline, add one
    sep = "" if readme_text.endswith("\n") else "\n"
    return f"{readme_text}{sep}\n\n{new_section}"

def main():
    new_section = generate_section()
    if README.exists():
        original = README.read_text(encoding="utf-8", errors="ignore")
        updated = replace_section_in_readme(original, new_section)
    else:
        updated = new_section
    README.write_text(updated, encoding="utf-8")
    print("✅ README updated with submodule images and descriptions.")

if __name__ == "__main__":
    main()
