# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

DTB = base

../$(DTB).dtbo: $(DTB).dtsi
	dtc -I dts -O dtb -o $@ $< -q

clean:
	rm -rf $(DTB).dtbo
