## Build PYNQ SD Image for AUP-ZU3

### Prerequisites

**Required tools:**

* Ubuntu 22.04 LTS 64-bit host PC
* Passwordless SUDO privilege for the building user
* Roughly 35GB of free space (build process only, not accounting for Xilinx tools)
* At least 8GB of RAM (more is better)
* AMD PetaLinux 2024.1 and Vivado 2024.1

Retrieve the AUP-ZU3 board git into a NEW directory.

```shell
git clone https://github.com/Xilinx/AUP-ZU3.git <LOCAL_AUP-ZU3_REPO>
cd <LOCAL_AUP-ZU3_REPO> && git submodule init && git submodule update
```

### Build SD Image

PYNQ is a submodule and it points to the corresponding branch.

Configure and install build tools, this will take some effort and will be an iterative process. Install on your own any missing tools.

Inside the `<LOCAL_AUP-ZU3_REPO>/` execute

```shell
cd pynq/sdbuild
make checkenv
```

The AUP-ZU3 comes in two configurations: 4GB and 8GB DDR4

Each board is marked as 4G (4GB) and 8G (8GB)

Run the corresponding makefile with `image-4gb` or `image-8gb` accordingly.

In the root directory (`<LOCAL_AUP-ZU3_REPO>/`) run `make`.

```shell
make image-4gb 2>&1 | tee build.log
```

OR

```shell
make image-8gb 2>&1 | tee build.log
```

Once the build has completed, if successful a SD card image will be available under the directory `<LOCAL_AUP-ZU3_REPO>/sdbuild/output/AUP-ZU3-3.1.img`.

Use Etcher or Win32DiskImager to write this image to an SD card.

---------------------------------------
<p class="copyright">Copyright&copy; 202-2025 Advanced Micro Devices</p>
