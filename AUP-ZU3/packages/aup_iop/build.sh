#!/bin/bash
# Copyright (C) 2022-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pkg="$script_dir/aup_iop"
root="$(cd "$script_dir/../../.." && pwd)"
xsa="$root/base/base.xsa"
sw_repo="$root/pynq/boards/sw_repo"

if [ ! -f "$xsa" ]; then
    echo "error: $xsa not found; build the base overlay first" >&2
    exit 1
fi

cd "$sw_repo"
make clean
make "XSA=$xsa"

shopt -s nullglob
found=0
for built in bsp_iop_*_mb; do
    found=1
    short="${built%_mb}"
    src=""
    for candidate in "$built"/*/standalone_domain/bsp; do
        if [ -d "$candidate" ]; then
            src="$candidate"
            break
        fi
    done
    if [ -z "$src" ]; then
        echo "error: no standalone BSP under $built" >&2
        exit 1
    fi
    case "$short" in
        bsp_iop_grove0) dest="$pkg/gc/$short" ;;
        bsp_iop_rpi0) dest="$pkg/rpi/$short" ;;
        *) dest="$pkg/$short" ;;
    esac
    rm -rf "$dest"
    mkdir -p "$(dirname "$dest")"
    cp -a "$src" "$dest"
    rm -rf "$dest"/*/code "$dest"/*/libsrc
    # Use the image compiler's C runtime, not the Vitis toolchain's libraries.
    find "$dest" -type f -path '*/lib/*' ! -name libxil.a -delete
done
make clean

if [ "$found" -eq 0 ]; then
    echo "error: sw_repo produced no MicroBlaze BSPs from $xsa" >&2
    exit 1
fi
