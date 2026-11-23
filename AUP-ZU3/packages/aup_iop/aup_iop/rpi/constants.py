# Copyright (C) 2016-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

import os

BIN_LOCATION = os.path.dirname(os.path.realpath(__file__)) + "/"
BSP_LOCATION = os.path.join(BIN_LOCATION, "bsp_iop_rpi0")

MAILBOX_OFFSET = 0xF000
MAILBOX_SIZE = 0x1000
MAILBOX_PY2IOP_CMD_OFFSET = 0xffc
MAILBOX_PY2IOP_ADDR_OFFSET = 0xff8
MAILBOX_PY2IOP_DATA_OFFSET = 0xf00

WRITE_CMD = 0
READ_CMD = 1
IOP_MMIO_REGSIZE = 0x10000
