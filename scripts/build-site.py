"""Package only the presentation; never initialise or publish device submodules."""
from pathlib import Path
import json
import shutil
import subprocess

ROOT = Path(__file__).resolve().parent.parent
PORTAL_STYLE = """
:root{color-scheme:dark;--operators:#d5ff5f;--bridges:#63d8ff;--morphisms:#bb9bff;--agents:#ff9e6b}*{box-sizing:border-box}body{margin:0;background:#10131b;color:#f0f2f7;font:16px Arial,Helvetica,sans-serif}.instrument{padding:16px}header{display:flex;justify-content:space-between;align-items:center;gap:12px}h1{font-size:18px;letter-spacing:-.03em;margin:0}h1 span{font:16px monospace;color:#d5ff5f}header>span{font:12px monospace;color:#a5acba}canvas{display:block;width:100%;height:205px;touch-action:pan-y}.layer-controls{display:grid;grid-template-columns:1fr 1fr;border-top:1px solid #353d4c;border-left:1px solid #353d4c}.layer-controls button{font:14px Arial,sans-serif;text-align:left;color:#a5acba;border:0;border-right:1px solid #353d4c;border-bottom:1px solid #353d4c;background:transparent;min-height:40px;padding:10px;cursor:pointer}.layer-controls span{font:12px monospace;margin-right:8px}.layer-controls button:nth-child(1){--layer:#d5ff5f}.layer-controls button:nth-child(2){--layer:#63d8ff}.layer-controls button:nth-child(3){--layer:#bb9bff}.layer-controls button:nth-child(4){--layer:#ff9e6b}.layer-controls button[aria-pressed=true]{color:var(--layer);background:#ffffff08;box-shadow:inset 3px 0 var(--layer)}.scene-caption{margin-top:14px;min-height:70px}.scene-caption strong{font-size:14px;font-weight:400;color:#d5ff5f}.scene-caption p{font-size:14px;line-height:1.4;color:#a5acba;margin:6px 0 14px}footer{display:flex;gap:8px;align-items:center;justify-content:space-between;flex-wrap:wrap}footer>span{font:12px/1.4 monospace;color:#a5acba}footer>div{display:flex;gap:8px}footer button{font:14px Arial,sans-serif;padding:8px;color:#f0f2f7;border:1px solid #535d70;background:transparent;cursor:pointer;min-height:36px}button:hover{background:#ffffff0c}button:focus-visible{outline:2px solid #d5ff5f;outline-offset:2px}button:disabled{opacity:.5;cursor:default}@media(max-width:350px){.instrument{padding:12px}canvas{height:170px}header>span{display:none}.scene-caption{min-height:84px}}
"""
def main():
    scene = (ROOT/'site/scene.js').read_text()
    preview = f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Tesserakt 2.0 — interactive preview</title><style>{PORTAL_STYLE}</style></head>
<body><main class="instrument" data-instrument><header><h1>TESSERAKT <span>2.0</span></h1><span>FOUR LAYERS / ONE SYSTEM</span></header>
<canvas role="img" aria-label="A tesseract projection. Select a layer to highlight a different set of connections."></canvas>
<div class="layer-controls" role="group" aria-label="Explore a layer"><button data-layer="0" type="button" aria-pressed="true"><span>01</span>Operators</button><button data-layer="1" type="button" aria-pressed="false"><span>02</span>Bridges</button><button data-layer="2" type="button" aria-pressed="false"><span>03</span>Morphisms</button><button data-layer="3" type="button" aria-pressed="false"><span>04</span>Agents</button></div>
<div class="scene-caption" aria-live="polite"><strong data-layer-title>Operators · transform an event</strong><p data-layer-description>Elementary MIDI operations: delay, mirror, scale, select or trigger.</p></div>
<footer><span>Illustrative · silent · no MIDI</span><div><button data-pulse type="button">Send a pulse</button><button data-motion type="button" aria-pressed="true">Pause motion</button></div></footer>
<noscript><p>Operators transform; bridges connect; morphisms articulate; agents organise.</p></noscript></main><script>{scene}</script></body></html>
'''
    (ROOT/'portal/index.html').write_text(preview)
    out = ROOT/'_site'
    if out.exists(): shutil.rmtree(out)
    out.mkdir()
    for folder in ('site','portal'):
        shutil.copytree(ROOT/folder, out/folder, ignore=shutil.ignore_patterns('README.md'))
    (out/'index.html').write_text('<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url=./site/"><title>Tesserakt 2.0</title></head><body><a href="./site/">Open Tesserakt 2.0</a></body></html>\n')
    (out/'.nojekyll').touch()
    sha = subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    (out/'version.json').write_text(json.dumps({'commit':sha})+'\n')
    print('Built _site/: site, self-contained portal preview, root redirect and version stamp.')

if __name__ == '__main__': main()
