# Tesserakt 2.0 · PORTAL presentation

This folder implements [MUK-research/PORTAL's version 1 contract](https://github.com/MUK-research/PORTAL/blob/main/docs/PROJECTS.md).

- `metadata.json` owns the title, description, credits, links and thumbnail path.
- `preview.svg` is a geometric thumbnail of the four-layer architecture.
- `index.html` is a self-contained, silent interactive tesseract projection. It is a visual metaphor, not an emulation of a Max for Live patch.
- The full presentation is at `../site/`.

The iframe needs only `sandbox="allow-scripts"`. It uses inline CSS and classic JavaScript; no fetches, imports, storage, audio or hardware permissions. It emits `prl:ready` and `prl:resize` with the supplied token and accepts visibility messages only from its parent with a matching nonempty token. Initial `motion=off`, reduced motion, background tabs, offscreen content and the local motion button pause animation. Parent inactivity cannot be overridden by a local control. Layer buttons and pulse work with keyboard and touch, including in a paused frame.

The scene source is `site/scene.js`. Run `python scripts/build-site.py` after changing it or the preview template/style in that script; commit the regenerated `portal/index.html` alongside the source. The build copies both `site/` and `portal/` to `_site/`, without checking out any device submodules.

Register only this pointer in the central portal:

```json
{
  "id": "tesserakt",
  "manifest": "https://adrianartacho.github.io/TesserAkt/portal/metadata.json"
}
```

GitHub Pages must publish the Actions artifact. In repository Settings → Pages → Source, choose GitHub Actions. The workflow does not change repository visibility or Pages settings. Project content remains here; the central registry does not duplicate descriptions or credits.
