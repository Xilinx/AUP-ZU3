# Copyright (C) 2022-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

import pynq
import pynq.lib
from pynq.lib import AxiGPIO

import aup_iop


class rgbleds_class(AxiGPIO):
    def write(self, value):
        super().write(0, value)

    def off(self):
        self.write(0)

    def on(self):
        self.write(0x0f)


class BaseOverlay(pynq.Overlay):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.is_loaded():
            self.iop_pmod0.mbtype = "Pmod"
            self.iop_pmod1.mbtype = "Pmod"
            self.iop_rpi0.mbtype = "Rpi"

            self.PMOD0 = self.iop_pmod0.mb_info
            self.PMOD1 = self.iop_pmod1.mb_info
            self.PMODA = self.PMOD0
            self.PMODB = self.PMOD1
            self.RPI = self.iop_rpi0.mb_info

            self.leds = self.pl_user_led.channel1
            self.leds.setdirection('out')
            self.leds.setlength(8)
            self.rgbleds = [rgbleds_class(self.ip_dict[f"pl_rgb{i}_led"]) for i in range(4)]
            self.buttons = self.pl_user_pb.channel1
            self.buttons.setdirection('in')
            self.buttons.setlength(4)
            self.switches = self.pl_user_sw.channel1
            self.switches.setdirection('in')
            self.switches.setlength(8)

            self.iop_grove0.mbtype = "GC"
            self.GC = self.iop_grove0.mb_info
            self.Rpi = aup_iop.Rpi
            self.Grove = aup_iop.GC
