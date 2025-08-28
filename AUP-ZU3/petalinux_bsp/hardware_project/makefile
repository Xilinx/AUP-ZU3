# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

overlay_name := aupzu3
design_name := aupzu3

AUP_ZU3_DDR4_CONFIG ?= 4

all: block_design bitstream
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

block_design:
	vivado -mode batch -source $(overlay_name).tcl -notrace -tclargs $(AUP_ZU3_DDR4_CONFIG)

bitstream:
	vivado -mode batch -source build_bitstream.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA .Xil *.bit *.hwh *.xsa

