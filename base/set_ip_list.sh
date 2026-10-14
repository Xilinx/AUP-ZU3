# Copyright (C) 2026 Advanced Micro Devices, Inc.

# SPDX-License-Identifier: BSD-3-Clause

#!/bin/bash

cd "$(dirname "$0")"

sed -i 's|set ip {color_convert_2 pixel_pack_2 pixel_unpack_2 trace_cntrl_32 trace_cntrl_64}|set ip {pixel_pack_2 pixel_unpack_2}|' \
    ../pynq/boards/ZCU104/base/build_ip.tcl

echo "Patched ../pynq/boards/ZCU104/base/build_ip.tcl"
