# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

SRC_URI:append = " \
        "
  
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

#Enable appropriate FSBL debug flags  
YAML_COMPILER_FLAGS:append = " -DFSBL_PRINT"
