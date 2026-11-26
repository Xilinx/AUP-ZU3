# Copyright (C) 2016-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

import os

from pynq.lib import PynqMicroblaze
from pynq.lib.pynqmicroblaze import add_bsp

from . import BIN_LOCATION, BSP_LOCATION, MAILBOX_OFFSET, MAILBOX_PY2IOP_CMD_OFFSET


class Rpi(PynqMicroblaze):
    """Raspberry Pi header MicroBlaze on AUP-ZU3."""

    def __init__(self, mb_info, mb_program):
        if not os.path.isabs(mb_program):
            mb_program = os.path.join(BIN_LOCATION, mb_program)
        super().__init__(mb_info, mb_program)

    def write_mailbox(self, data_offset, data):
        self.write(MAILBOX_OFFSET + data_offset, data)

    def read_mailbox(self, data_offset, num_words=1):
        return self.read(MAILBOX_OFFSET + data_offset, num_words)

    def write_blocking_command(self, command):
        self.write(MAILBOX_OFFSET + MAILBOX_PY2IOP_CMD_OFFSET, command)
        while self.read(MAILBOX_OFFSET + MAILBOX_PY2IOP_CMD_OFFSET) != 0:
            pass

    def write_non_blocking_command(self, command):
        self.write(MAILBOX_OFFSET + MAILBOX_PY2IOP_CMD_OFFSET, command)


if os.path.exists(BSP_LOCATION):
    add_bsp(BSP_LOCATION)
