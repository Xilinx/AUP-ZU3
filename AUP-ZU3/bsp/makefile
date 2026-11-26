# Copyright (C) 2025-2026 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

overlay_name := bsp

AUP_ZU3_DDR4_CONFIG ?= 4

all: $(overlay_name).xsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

$(overlay_name).xsa:
	vivado -mode batch -source bsp.tcl -notrace -tclargs $(AUP_ZU3_DDR4_CONFIG)

clean:
	rm -rf $(overlay_name) *.jou *.log NA .Xil $(overlay_name).xsa
