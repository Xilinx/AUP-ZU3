# Copyright (C) 2025 Advanced Micro Devices

# SPDX-License-Identifier: BSD-3-Clause

ROOT_PATH := $(abspath $(dir $(firstword $(MAKEFILE_LIST))))
REPO_NAME := $(notdir $(ROOT_PATH))

PREBUILT_IMAGE := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_rootfs.aarch64.tar.gz
PREBUILT_SDIST := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_sdist.tar.gz

## Build 4GB image by default
default: image-4gb

image-4gb: AUP_ZU3_DDR4_CONFIG := 4
image-4gb: image

image-8gb: AUP_ZU3_DDR4_CONFIG := 8
image-8gb: image

image: gitsubmodule ${PREBUILT_SDIST} ${PREBUILT_IMAGE} base
	echo "Building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB Image"
	export AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}; cd ${ROOT_PATH}/pynq/sdbuild/ && make BOARDDIR=${ROOT_PATH} BOARDS=${REPO_NAME} PYNQ_SDIST=${PREBUILT_SDIST} PYNQ_ROOTFS=${PREBUILT_IMAGE}
	echo "Finished building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB Image"

base: ${ROOT_PATH}/base/base.bit

${ROOT_PATH}/base/base.bit:
	echo "Building base bitstream"
	cd ${ROOT_PATH}/base && make AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}

gitsubmodule:
	echo "Update submodule"
	git submodule init && git submodule update

${PREBUILT_IMAGE}:
	wget https://download.amd.com/opendownload/pynq/jammy.aarch64.3.1.0.tar.gz -O $@
	@echo "Got $@"

${PREBUILT_SDIST}:
	wget https://download.amd.com/opendownload/pynq/pynq-3.1.tar.gz -O $@
	@echo "Got $@"

cleanbuild:
	sudo make -C pynq/sdbuild/ clean
	cd ${ROOT_PATH}/base && make clean
