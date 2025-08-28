#!/bin/bash

# Copyright (C) 2025 Advanced Micro Devices, Inc
# SPDX-License-Identifier: BSD-3-Clause

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp $script_dir/pcam5c.py $target/usr/local/share/pynq-venv/lib/python3.10/site-packages/pynq/lib/video/pcam5c.py
sudo cp $script_dir/base.dtbo $target/usr/local/share/pynq-venv/lib/python3.10/site-packages/pynq/overlays/base/base.dtbo
