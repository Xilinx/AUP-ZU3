# Copyright (C) 2025 Advanced Micro Devices

# SPDX-License-Identifier: BSD-3-Clause

ROOT_PATH := $(abspath $(dir $(firstword $(MAKEFILE_LIST))))
BOARD ?= AUP-ZU3
VERSION := 4.0.0

PREBUILT_IMAGE := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_rootfs.aarch64.tar.gz
PREBUILT_SDIST := ${ROOT_PATH}/pynq/sdbuild/prebuilt/pynq_sdist.tar.gz

## Build 4GB image by default
default: image-4gb

image-4gb: AUP_ZU3_DDR4_CONFIG := 4
image-4gb: image

image-8gb: AUP_ZU3_DDR4_CONFIG := 8
image-8gb: image

image: gitsubmodule ${PREBUILT_SDIST} ${PREBUILT_IMAGE} base bsp
	echo "Building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB Image"
	export AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}; cd ${ROOT_PATH}/pynq/sdbuild/ && make BOARDDIR=${ROOT_PATH} BOARDS=${BOARD} PYNQ_SDIST=${PREBUILT_SDIST} PYNQ_ROOTFS=${PREBUILT_IMAGE}
	mv ${ROOT_PATH}/pynq/sdbuild/output/${BOARD}-${VERSION}.img ${ROOT_PATH}/
	echo "Finished building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB Image"

base: ${ROOT_PATH}/base/base.bit

${ROOT_PATH}/base/base.bit:
	echo "Building base bitstream"
	cd ${ROOT_PATH}/base && make AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}

bsp: ${ROOT_PATH}/AUP-ZU3/bsp/bsp.xsa

${ROOT_PATH}/AUP-ZU3/bsp/bsp.xsa:
	echo "Building BSP XSA"
	cd ${ROOT_PATH}/AUP-ZU3/bsp && make AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}

gitsubmodule:
	echo "Update submodule"
	git submodule init && git submodule update

${PREBUILT_IMAGE}:
	wget https://download.amd.com/opendownload/pynq/noble.aarch64.4.0.0.tar.gz -O $@
	@echo "Got $@"

${PREBUILT_SDIST}:
	wget https://download.amd.com/opendownload/pynq/pynq-4.0.0.tar.gz -O $@
	@echo "Got $@"

pynqremote-4gb: AUP_ZU3_DDR4_CONFIG := 4
pynqremote-4gb: pynqremote

pynqremote-8gb: AUP_ZU3_DDR4_CONFIG := 8
pynqremote-8gb: pynqremote

pynqremote: gitsubmodule ${PREBUILT_SDIST} ${PREBUILT_IMAGE} base bsp
	echo "Building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB PYNQ.remote Image"
	export AUP_ZU3_DDR4_CONFIG=${AUP_ZU3_DDR4_CONFIG}; cd ${ROOT_PATH}/pynq/sdbuild/ && make pynqremote BOARDDIR=${ROOT_PATH} BOARDS=${BOARD} PYNQ_SDIST=${PREBUILT_SDIST} PYNQ_ROOTFS=${PREBUILT_IMAGE}
	mv ${ROOT_PATH}/pynq/sdbuild/output/${BOARD}-${VERSION}-remote.img ${ROOT_PATH}/
	echo "Finished building AUP-ZU3 ${AUP_ZU3_DDR4_CONFIG}GB PYNQ.remote Image"

cleanbuild:
	sudo make -C pynq/sdbuild/ clean
	cd ${ROOT_PATH}/base && make clean
	cd ${ROOT_PATH}/AUP-ZU3/bsp && make clean
