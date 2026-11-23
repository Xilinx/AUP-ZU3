# Copyright (C) 2022-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

"""MicroBlaze IOP drivers and BSPs for AUP-ZU3."""

from pathlib import Path

from pynq.lib.pynqmicroblaze import add_bsp
from pynq.lib.pynqmicroblaze.bsp import add_module_path

from .gc import GC
from .rpi import Rpi

_ROOT = Path(__file__).resolve().parent

for _modules in (_ROOT / "grove_modules", _ROOT / "modules"):
    if _modules.is_dir():
        add_module_path(str(_modules))

for _bsp in sorted(_ROOT.glob("bsp_iop_*")):
    if _bsp.is_dir():
        add_bsp(str(_bsp))

__all__ = ["GC", "Rpi"]
