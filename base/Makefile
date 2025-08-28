# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

overlay_name := base
design_name := base

AUP_ZU3_DDR4_CONFIG := 4

all:  block_design bitstream dts check_timing
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

hls_ip:
	git submodule init && git submodule update
	vivado -mode batch -source build_ip.tcl -notrace

block_design: hls_ip
	vivado -mode batch -source $(overlay_name).tcl -notrace -tclargs $(AUP_ZU3_DDR4_CONFIG)

# Workaround for Vivado Flexera/Revenera issue AR: 000034450
# https://adaptivesupport.amd.com/s/article/000034450?language=en_US
bitstream:
	@if [ -f /.dockerenv ]; then \
		echo "Running in Docker. Using LD_PRELOAD..."; \
		LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado -mode batch -source build_bitstream.tcl -notrace; \
	else \
		vivado -mode batch -source build_bitstream.tcl; \
	fi

dts: $(overlay_name).dtbo

$(overlay_name).dtbo:
	make -C dts

check_timing:
	vivado -mode batch -source check_timing.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA .Xil *.zip *.str *.hwh *.xsa *.bit *.dtbo
