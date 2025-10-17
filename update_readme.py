# !/usr/bin/env python3
import re, os

try:
    import requests
except ImportError:
    import subprocess, sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
    import requests

README = "README.md"
SECTION_HEADER = "## Submodules"

# --- 1. Parse .gitmodules ---
submodules = []
with open(".gitmodules") as f:
    current = {}
    for line in f:
        line = line.strip()
        if line.startswith("[submodule"):
            if current: submodules.append(current)
            current = {}
        elif "=" in line:
            key, val = [x.strip() for x in line.split("=", 1)]
            current[key] = val
    if current: submodules.append(current)

# --- 2. Fetch description from GitHub API ---
rows = []
for s in submodules:
    url = s.get("url", "")
    if "github.com" not in url:
        desc = "(non-GitHub repo)"
    else:
        # extract "owner/repo"
        repo = re.search(r"github\.com[:/](.*?)(?:\.git)?$", url).group(1)
        api = f"https://api.github.com/repos/{repo}"
        r = requests.get(api)
        desc = r.json().get("description", "")
        url = f"https://github.com/{repo}"
    name = os.path.basename(s["path"])
    rows.append(f"| [{name}]({url}) | {desc} |")

# --- 3. Rewrite section in README.md ---
table = ["| Name | Description |", "|------|--------------|"] + rows
new_section = SECTION_HEADER + "\n\n" + "\n".join(table) + "\n"

if os.path.exists(README):
    with open(README) as f:
        content = f.read()
    # replace or append
    if SECTION_HEADER in content:
        content = re.sub(rf"{SECTION_HEADER}[\s\S]*?(?=\n## |\Z)", new_section, content)
    else:
        content += "\n\n" + new_section
else:
    content = new_section

with open(README, "w") as f:
    f.write(content)

print("✅ README updated.")