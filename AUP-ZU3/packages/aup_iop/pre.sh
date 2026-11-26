#!/bin/bash
# Copyright (C) 2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

set -euo pipefail

target=$1
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$script_dir/build.sh"

site=$(echo "$target"/usr/local/share/pynq-venv/lib/python3.*/site-packages)
if [ ! -d "$site" ]; then
    echo "error: pynq venv site-packages not found under $target" >&2
    exit 1
fi
sudo mkdir -p "$site/aup_iop"
sudo rsync -a --exclude=__pycache__ --exclude="*.pyc" "$script_dir/aup_iop/" "$site/aup_iop/"
