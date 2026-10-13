"""Build the live Partnership Desk page.

Reads app/src/partnership-desk.src.html, replaces __LOGO__ with the base64 of
demo/src/cbs-talks-logo.jpg and writes app/partnership-desk.html, the file that is
published as a private claude.ai page.

    python3 tools/build_app.py
"""
import base64
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
src = (ROOT / "app/src/partnership-desk.src.html").read_text(encoding="utf-8")
logo = base64.b64encode((ROOT / "demo/src/cbs-talks-logo.jpg").read_bytes()).decode()
out = ROOT / "app/partnership-desk.html"
out.write_text(src.replace("__LOGO__", logo), encoding="utf-8")
print(f"Wrote {out.relative_to(ROOT)} ({out.stat().st_size // 1024} KB)")
