#!/bin/bash

# Copyright (C) 2025 Advanced Micro Devices, Inc
# SPDX-License-Identifier: BSD-3-Clause

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp $script_dir/eth0 $target/etc/netplan/01-netcfg.yaml
