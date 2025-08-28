# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

SRC_URI:append = " file://bsp.cfg"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
