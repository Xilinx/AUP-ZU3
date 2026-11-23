#!/bin/bash
# Copyright (C) 2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

set -euo pipefail

target=$1
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo install -D -m 644 "$script_dir/usbgadget-stop.conf" \
    "$target/etc/systemd/system/usbgadget.service.d/aup-zu3.conf"
