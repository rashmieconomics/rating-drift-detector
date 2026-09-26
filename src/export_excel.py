"""Run the standard pipeline and create the Excel analyst workbook."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

if __name__ == "__main__":
    subprocess.run([sys.executable, "-m", "src.pipeline"], cwd=ROOT, check=True)
    subprocess.run(["node", "src/build_workbook.mjs"], cwd=ROOT, check=True)
