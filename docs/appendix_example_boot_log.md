# Example boot log

```
Zynq MP First Stage Boot Loader
Release 2024.1   May 19 2024  -  02:40:12
NOTICE:  BL31: Non secure code at 0x8000000
NOTICE:  BL31: v2.10.0  (release):v1.1-13187-g4f82b6134
NOTICE:  BL31: Built : 04:45:53, Mar 12 2024


U-Boot 2024.01 (May 14 2024 - 03:31:48 +0000)

CPU:   ZynqMP
Silicon: v3
Chip:  zu3eg
Model: AUP-ZU3 v1.0
Board: Xilinx ZynqMP
DRAM:  2 GiB (effective 4 GiB)
PMUFW:  v1.1
EL Level:       EL2
Secure Boot:    not authenticated, not encrypted
Core:  43 devices, 23 uclasses, devicetree: board
NAND:  0 MiB
MMC:   mmc@ff160000: 0
Loading Environment from FAT... *** Error - No Valid Environment Area found
*** Warning - bad env area, using default environment

In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Bootmode: SD_MODE
Reset reason:   EXTERNAL
Net:   No ethernet found.
scanning bus for devices...
starting USB...
Bus usb@fe300000: Register 2000440 NbrPorts 2
Starting the controller
USB XHCI 1.00
scanning bus usb@fe300000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot.scr
3474 bytes read in 9 ms (377 KiB/s)
## Executing script at 20000000
Trying to load boot images from mmc0
26392684 bytes read in 1702 ms (14.8 MiB/s)
## Loading kernel from FIT Image at 10000000 ...
   Using 'conf-1' configuration
   Trying 'kernel-0' kernel subimage
     Description:  Linux Kernel
     Created:      2025-06-18  13:28:44 UTC
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x100000d4
     Data Size:    26352128 Bytes = 25.1 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x00080000
     Entry Point:  0x00080000
     Hash algo:    sha1
     Hash value:   38b78e4c504dd64922294b9e870c29bd01b3241a
   Verifying Hash Integrity ... sha1+ OK
## Loading fdt from FIT Image at 10000000 ...
   Using 'conf-1' configuration
   Trying 'fdt-0' fdt subimage
     Description:  Flattened Device Tree blob
     Created:      2025-06-18  13:28:44 UTC
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x11921bcc
     Data Size:    38731 Bytes = 37.8 KiB
     Architecture: AArch64
     Hash algo:    sha1
     Hash value:   0acc83a959c3ca4e6c9b672e88d9420b4d49800d
   Verifying Hash Integrity ... sha1+ OK
   Booting using the fdt blob at 0x11921bcc
Working FDT set to 11921bcc
   Loading Kernel Image
   Loading Device Tree to 0000000077bd6000, end 0000000077be274a ... OK
Working FDT set to 77bd6000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.6.10-xilinx-v2024.1-g11d515574674 (oe-user@oe-host) (aarch64-xilinx-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #1 SMP Sat Apr 27 05:22:24 UTC 2024
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: AUP-ZU3 v1.0
[    0.000000] efi: UEFI not found.
[    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fefffff]
[    0.000000]   node   0: [mem 0x0000000800000000-0x000000087fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000087fffffff]
[    0.000000] On node 0, zone Normal: 256 pages in unavailable ranges
[    0.000000] cma: Reserved 128 MiB at 0x0000000077e00000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.4
[    0.000000] percpu: Embedded 20 pages/cpu s43496 r8192 d30232 u81920
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 rw earlyprintk rootfstype=ext4 rootwait devtmpfs.mount=1 uio_pdrv_genirq.of_id="generic-uio" clk_ignore_unused
[    0.000000] Unknown kernel command line parameters "earlyprintk", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1031940
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x0000000073bd6000-0x0000000077bd6000] (64MB)
[    0.000000] Memory: 3889236K/4193280K available (16832K kernel code, 1094K rwdata, 4728K rodata, 2944K init, 460K bss, 172972K reserved, 131072K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Adjusting CPU interface base to 0x00000000f902f000
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 33.33MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x7b00c3848, max_idle_ns: 440795203375 ns
[    0.000000] sched_clock: 56 bits at 33MHz, resolution 30ns, wraps every 2199023255545ns
[    0.000193] Console: colour dummy device 80x25
[    0.000202] printk: console [tty0] enabled
[    0.000503] Calibrating delay loop (skipped), value calculated using timer frequency.. 66.66 BogoMIPS (lpj=133333)
[    0.000522] pid_max: default: 32768 minimum: 301
[    0.000644] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000671] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.001500] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.002095] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.002258] rcu: Hierarchical SRCU implementation.
[    0.002270] rcu:     Max phase no-delay instances is 1000.
[    0.002547] EFI services will not be available.
[    0.002735] smp: Bringing up secondary CPUs ...
[    0.003147] Detected VIPT I-cache on CPU1
[    0.003194] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.003644] Detected VIPT I-cache on CPU2
[    0.003674] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.004117] Detected VIPT I-cache on CPU3
[    0.004146] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.004199] smp: Brought up 1 node, 4 CPUs
[    0.004242] SMP: Total of 4 processors activated.
[    0.004251] CPU features: detected: 32-bit EL0 Support
[    0.004260] CPU features: detected: CRC32 instructions
[    0.004324] CPU: All CPU(s) started at EL2
[    0.004333] alternatives: applying system-wide alternatives
[    0.006118] devtmpfs: initialized
[    0.011460] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.011484] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.014637] pinctrl core: initialized pinctrl subsystem
[    0.015071] DMI not present or invalid.
[    0.015672] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.016569] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.016677] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.016720] audit: initializing netlink subsys (disabled)
[    0.016830] audit: type=2000 audit(0.016:1): state=initialized audit_enabled=0 res=1
[    0.017271] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.017341] ASID allocator initialised with 65536 entries
[    0.017490] Serial: AMBA PL011 UART driver
[    0.026438] Modules: 26208 pages in range for non-PLT usage
[    0.026444] Modules: 517728 pages in range for PLT usage
[    0.026991] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.027010] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.027021] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.027030] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.027041] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.027050] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.027060] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.027069] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.092093] raid6: neonx8   gen()  2259 MB/s
[    0.160161] raid6: neonx4   gen()  2211 MB/s
[    0.228226] raid6: neonx2   gen()  2124 MB/s
[    0.296297] raid6: neonx1   gen()  1814 MB/s
[    0.364349] raid6: int64x8  gen()  1415 MB/s
[    0.432424] raid6: int64x4  gen()  1568 MB/s
[    0.500482] raid6: int64x2  gen()  1392 MB/s
[    0.568557] raid6: int64x1  gen()  1034 MB/s
[    0.568567] raid6: using algorithm neonx8 gen() 2259 MB/s
[    0.636599] raid6: .... xor() 1656 MB/s, rmw enabled
[    0.636610] raid6: using neon recovery algorithm
[    0.637078] iommu: Default domain type: Translated
[    0.637090] iommu: DMA domain TLB invalidation policy: strict mode
[    0.637363] SCSI subsystem initialized
[    0.637535] usbcore: registered new interface driver usbfs
[    0.637566] usbcore: registered new interface driver hub
[    0.637597] usbcore: registered new device driver usb
[    0.637698] mc: Linux media interface: v0.10
[    0.637734] videodev: Linux video capture interface: v2.00
[    0.637771] pps_core: LinuxPPS API ver. 1 registered
[    0.637780] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.637802] PTP clock support registered
[    0.637837] EDAC MC: Ver: 3.0.0
[    0.638146] zynqmp-ipi-mbox mailbox@ff9905c0: Registered ZynqMP IPI mbox with TX/RX channels.
[    0.638464] FPGA manager framework
[    0.638601] Advanced Linux Sound Architecture Driver Initialized.
[    0.639034] Bluetooth: Core ver 2.22
[    0.639065] NET: Registered PF_BLUETOOTH protocol family
[    0.639074] Bluetooth: HCI device and connection manager initialized
[    0.639088] Bluetooth: HCI socket layer initialized
[    0.639099] Bluetooth: L2CAP socket layer initialized
[    0.639115] Bluetooth: SCO socket layer initialized
[    0.639602] clocksource: Switched to clocksource arch_sys_counter
[    0.639770] VFS: Disk quotas dquot_6.6.0
[    0.639801] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.645221] NET: Registered PF_INET protocol family
[    0.645411] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.648164] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.648212] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.648231] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.648449] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.649541] TCP: Hash tables configured (established 32768 bind 32768)
[    0.649633] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.649716] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.649876] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.650274] RPC: Registered named UNIX socket transport module.
[    0.650286] RPC: Registered udp transport module.
[    0.650295] RPC: Registered tcp transport module.
[    0.650302] RPC: Registered tcp-with-tls transport module.
[    0.650311] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.651297] PCI: CLS 0 bytes, default 64
[    0.652592] Initialise system trusted keyrings
[    0.652706] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.652943] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.653213] NFS: Registering the id_resolver key type
[    0.653239] Key type id_resolver registered
[    0.653248] Key type id_legacy registered
[    0.653271] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.653287] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.653511] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    0.686850] NET: Registered PF_ALG protocol family
[    0.686867] xor: measuring software checksum speed
[    0.690782]    8regs           :  2524 MB/sec
[    0.694695]    32regs          :  2524 MB/sec
[    0.698871]    arm64_neon      :  2364 MB/sec
[    0.698880] xor: using function: 32regs (2524 MB/sec)
[    0.698894] Key type asymmetric registered
[    0.698904] Asymmetric key parser 'x509' registered
[    0.698945] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.699040] io scheduler mq-deadline registered
[    0.699052] io scheduler kyber registered
[    0.699076] io scheduler bfq registered
[    0.736780] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.738243] Serial: AMBA driver
[    0.744681] brd: module loaded
[    0.748424] loop: module loaded
[    0.753016] tun: Universal TUN/TAP device driver, 1.6
[    0.753138] CAN device driver interface
[    0.753944] VFIO - User Level meta-driver version: 0.3
[    0.754380] usbcore: registered new interface driver cdc_acm
[    0.754392] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    0.754424] usbcore: registered new interface driver cdc_wdm
[    0.754452] usbcore: registered new interface driver usb-storage
[    0.754508] usbcore: registered new interface driver usbserial_generic
[    0.754533] usbserial: USB Serial support registered for generic
[    0.754561] usbcore: registered new interface driver usb_serial_simple
[    0.754585] usbserial: USB Serial support registered for carelink
[    0.754611] usbserial: USB Serial support registered for flashloader
[    0.754633] usbserial: USB Serial support registered for funsoft
[    0.754655] usbserial: USB Serial support registered for google
[    0.754678] usbserial: USB Serial support registered for hp4x
[    0.754700] usbserial: USB Serial support registered for kaufmann
[    0.754723] usbserial: USB Serial support registered for libtransistor
[    0.754746] usbserial: USB Serial support registered for moto_modem
[    0.754770] usbserial: USB Serial support registered for motorola_tetra
[    0.754793] usbserial: USB Serial support registered for nokia
[    0.754818] usbserial: USB Serial support registered for novatel_gps
[    0.754844] usbserial: USB Serial support registered for siemens_mpi
[    0.754867] usbserial: USB Serial support registered for suunto
[    0.754890] usbserial: USB Serial support registered for vivopay
[    0.754912] usbserial: USB Serial support registered for zio
[    0.755712] rtc_zynqmp ffa60000.rtc: registered as rtc0
[    0.755736] rtc_zynqmp ffa60000.rtc: setting system clock to 2036-04-27T22:49:34 UTC (2092949374)
[    0.755802] i2c_dev: i2c /dev entries driver
[    0.757880] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    0.757967] Bluetooth: HCI UART driver ver 2.3
[    0.757979] Bluetooth: HCI UART protocol H4 registered
[    0.757989] Bluetooth: HCI UART protocol BCSP registered
[    0.758014] Bluetooth: HCI UART protocol LL registered
[    0.758024] Bluetooth: HCI UART protocol ATH3K registered
[    0.758046] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    0.758087] Bluetooth: HCI UART protocol Intel registered
[    0.758111] Bluetooth: HCI UART protocol QCA registered
[    0.758144] usbcore: registered new interface driver bcm203x
[    0.758171] usbcore: registered new interface driver bpa10x
[    0.758198] usbcore: registered new interface driver bfusb
[    0.758225] usbcore: registered new interface driver btusb
[    0.758267] usbcore: registered new interface driver ath3k
[    0.758377] EDAC MC: ECC not enabled
[    0.758735] sdhci: Secure Digital Host Controller Interface driver
[    0.758746] sdhci: Copyright(c) Pierre Ossman
[    0.758754] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.759130] ledtrig-cpu: registered to indicate activity on CPUs
[    0.759197] SMCCC: SOC_ID: ID = jep106:0049:0000 Revision = 0x14710093
[    0.759277] zynqmp_firmware_probe Platform Management API v1.1
[    0.759334] zynqmp_firmware_probe Trustzone version v1.0
[    0.784222] securefw securefw: securefw probed
[    0.784509] zynqmp-aes zynqmp-aes.0: will run requests pump with realtime priority
[    0.785018] usbcore: registered new interface driver usbhid
[    0.785029] usbhid: USB HID core driver
[    0.787469] ARM CCI_400_r1 PMU driver probed
[    0.788058] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
[    0.788976] fpga_manager fpga0: Xilinx ZynqMP FPGA Manager registered
[    0.789383] usbcore: registered new interface driver snd-usb-audio
[    0.790111] pktgen: Packet Generator for packet performance testing. Version: 2.75
[    0.791002] IPVS: Registered protocols (TCP, UDP)
[    0.791019] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
[    0.791147] IPVS: ipvs loaded.
[    0.791160] IPVS: [rr] scheduler registered.
[    0.791294] Initializing XFRM netlink socket
[    0.791345] NET: Registered PF_INET6 protocol family
[    0.791980] Segment Routing with IPv6
[    0.792018] In-situ OAM (IOAM) with IPv6
[    0.792103] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.792485] NET: Registered PF_PACKET protocol family
[    0.792503] NET: Registered PF_KEY protocol family
[    0.792527] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    0.792542] can: controller area network core
[    0.792574] NET: Registered PF_CAN protocol family
[    0.792586] can: raw protocol
[    0.792595] can: broadcast manager protocol
[    0.792608] can: netlink gateway - max_hops=1
[    0.792695] Bluetooth: RFCOMM TTY layer initialized
[    0.792712] Bluetooth: RFCOMM socket layer initialized
[    0.792735] Bluetooth: RFCOMM ver 1.11
[    0.792750] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    0.792759] Bluetooth: BNEP filters: protocol multicast
[    0.792770] Bluetooth: BNEP socket layer initialized
[    0.792780] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.792791] Bluetooth: HIDP socket layer initialized
[    0.792834] 8021q: 802.1Q VLAN Support v1.8
[    0.792983] 9pnet: Installing 9P2000 support
[    0.793016] Key type dns_resolver registered
[    0.801219] registered taskstats version 1
[    0.801326] Loading compiled-in X.509 certificates
[    0.810111] Btrfs loaded, zoned=no, fsverity=no
[    0.810270] alg: No test for xilinx-zynqmp-rsa (zynqmp-rsa)
[    0.940145] "cryptomgr_test" (145) uses obsolete ecb(arc4) skcipher
[    1.254367] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 23, base_baud = 6249999) is a xuartps
[    1.254429] printk: console [ttyPS0] enabled
[    2.762504] of-fpga-region fpga-region: FPGA Region probed
[    2.772540] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
[    2.781404] zynqmp-display fd4a0000.display: vtc bridge property not present
[    2.919970] xilinx-dp-snd-codec fd4a0000.display:zynqmp-dp-snd-codec0: Failed to get required clock freq
[    2.929475] xilinx-dp-snd-codec: probe of fd4a0000.display:zynqmp-dp-snd-codec0 failed with error -22
[    2.938965] xilinx-dp-snd-pcm zynqmp_dp_snd_pcm0: Xilinx DisplayPort Sound PCM probed
[    2.947041] xilinx-dp-snd-pcm zynqmp_dp_snd_pcm1: Xilinx DisplayPort Sound PCM probed
[    2.955735] xlnx-drm xlnx-drm.0: bound fd4a0000.display (ops 0xffff8000811e80a8)
[    4.039630] zynqmp-display fd4a0000.display: [drm] Cannot find any crtc or sizes
[    4.047382] [drm] Initialized xlnx 1.0.0 20130509 for fd4a0000.display on minor 0
[    4.054918] zynqmp-display fd4a0000.display: ZynqMP DisplayPort Subsystem driver probed
[    4.063325] xilinx-axipmon ffa00000.perf-monitor: Probed Xilinx APM
[    4.069911] xilinx-axipmon fd0b0000.perf-monitor: Probed Xilinx APM
[    4.076448] xilinx-axipmon fd490000.perf-monitor: Probed Xilinx APM
[    4.082986] xilinx-axipmon ffa10000.perf-monitor: Probed Xilinx APM
[    4.167851] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.173387] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    4.181220] xhci-hcd xhci-hcd.1.auto: hcc params 0x0238f625 hci version 0x100 quirks 0x0000000022000810
[    4.190667] xhci-hcd xhci-hcd.1.auto: irq 46, io mem 0xfe300000
[    4.196740] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.202260] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    4.209946] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    4.216634] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
[    4.224927] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.232173] usb usb1: Product: xHCI Host Controller
[    4.237073] usb usb1: Manufacturer: Linux 6.6.10-xilinx-v2024.1-g11d515574674 xhci-hcd
[    4.245006] usb usb1: SerialNumber: xhci-hcd.1.auto
[    4.250293] hub 1-0:1.0: USB hub found
[    4.254097] hub 1-0:1.0: 1 port detected
[    4.258391] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
[    4.266689] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.273942] usb usb2: Product: xHCI Host Controller
[    4.278841] usb usb2: Manufacturer: Linux 6.6.10-xilinx-v2024.1-g11d515574674 xhci-hcd
[    4.286782] usb usb2: SerialNumber: xhci-hcd.1.auto
[    4.292033] hub 2-0:1.0: USB hub found
[    4.295826] hub 2-0:1.0: 1 port detected
[    4.300413] cdns-i2c ff020000.i2c: can't get pinctrl, bus recovery not supported
[    4.308273] cdns-i2c ff020000.i2c: 400 kHz mmio ff020000 irq 47
[    4.314455] cdns-i2c ff030000.i2c: can't get pinctrl, bus recovery not supported
[    4.322247] cdns-i2c ff030000.i2c: 400 kHz mmio ff030000 irq 48
[    4.334662] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    4.341896] of_cfs_init
[    4.344392] of_cfs_init: OK
[    4.347265] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.363608] mmc0: SDHCI controller on ff160000.mmc [ff160000.mmc] using ADMA 64-bit
[    4.393146] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.399601] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    4.406886] clk: Not disabling unused clocks
[    4.411513] ALSA device list:
[    4.414499]   No soundcards found.
[    4.418301] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    4.426961] cfg80211: failed to load regulatory.db
[    4.431938] Waiting for root device /dev/mmcblk0p2...
[    4.446909] mmc0: new high speed SDXC card at address aaaa
[    4.452911] mmcblk0: mmc0:aaaa SN64G 59.5 GiB
[    4.458908]  mmcblk0: p1 p2
[    4.899689] EXT4-fs (mmcblk0p2): recovery complete
[    4.905854] EXT4-fs (mmcblk0p2): mounted filesystem b6058def-d5d2-4ffa-840b-7356db679aeb r/w with ordered data mode. Quota mode: none.
[    4.918024] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    4.924739] devtmpfs: mounted
[    4.928562] Freeing unused kernel memory: 2944K
[    4.933195] Run /sbin/init as init process
[    5.171641] zynqmp-display fd4a0000.display: [drm] Cannot find any crtc or sizes
[    5.585479] systemd[1]: systemd 249.11-0ubuntu3 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP -LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    5.616738] systemd[1]: Detected architecture arm64.

Welcome to PynqLinux, based on Ubuntu 22.04!

[    5.636407] systemd[1]: Hostname set to <pynq>.
[    5.704402] systemd[1]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[    6.362477] systemd[1]: Queued start job for default target Multi-User System.
[    8.727606] random: crng init done
[    8.753090] systemd[1]: Created slice Slice /system/modprobe.
[  OK  ] Created slice Slice /system/modprobe.
[    8.776841] systemd[1]: Created slice Slice /system/serial-getty.
[  OK  ] Created slice Slice /system/serial-getty.
[    8.800394] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    8.823906] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Started Dispatch Password …ts to Console Directory Watch.
[    8.847795] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password R…uests to Wall Directory Watch.
[    8.871908] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    8.883660] systemd[1]: Reached target Local Encrypted Volumes.
[  OK  ] Reached target Local Encrypted Volumes.
[    8.907830] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    8.927677] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[    8.943789] systemd[1]: Reached target Local Verity Protected Volumes.
[  OK  ] Reached target Local Verity Protected Volumes.
[    8.968093] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[    8.983865] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    9.014557] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[    9.031959] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    9.056027] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    9.072170] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[    9.096023] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    9.111987] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    9.143854] systemd[1]: Mounting Huge Pages File System...
         Mounting Huge Pages File System...
[    9.162715] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
[    9.182797] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[    9.200348] systemd[1]: Condition check resulted in Kernel Trace File System being skipped.
[    9.215741] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    9.237954] systemd[1]: Starting Restore / save the current clock...
         Starting Restore / save the current clock...
[    9.259575] systemd[1]: Starting Set the console keyboard layout...
         Starting Set the console keyboard layout...
[    9.275906] systemd[1]: Condition check resulted in Create List of Static Device Nodes being skipped.
[    9.288986] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[    9.311521] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[    9.331469] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[    9.347841] systemd[1]: Condition check resulted in OpenVSwitch configuration for cleanup being skipped.
[    9.360859] systemd[1]: Started Nameserver information manager.
[  OK  ] Started Nameserver information manager.
[    9.384127] systemd[1]: Reached target Preparation for Network.
[  OK  ] Reached target Preparation for Network.
[    9.448014] systemd[1]: Starting Load Kernel Modules...
         Starting Load Kernel Modules...
[    9.467061] systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
[    9.516100] systemd[1]: Starting Coldplug All udev Devices...
         Starting Coldplug All udev Devices...
[    9.536892] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Finished Restore / save the current clock.
[  OK  ] Finished Set the console keyboard layout.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Modules.
[  OK  ] Finished Remount Root and Kernel File Systems.
         Activating swap /var/swap...
         Mounting Kernel Configuration File System...
[    9.737967] Adding 524284k swap on /var/swap.  Priority:-2 extents:5 across:655360k SS
         Starting Flush Journal to Persistent Storage...
[    9.769100] systemd-journald[221]: Received client request to flush runtime journal.
         Starting Load/Save Random Seed...
         Starting Apply Kernel Variables...
         Starting Create System Users...
[    9.812531] systemd-journald[221]: File /var/log/journal/260fb05d7fe844f6a41c3b70f4a7958d/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  OK  ] Activated swap /var/swap.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Load/Save Random Seed.
[  OK  ] Finished Apply Kernel Variables.
[  OK  ] Reached target Swaps.
[  OK  ] Finished Create System Users.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Preparation for Local File Systems.
[  OK  ] Reached target Local File Systems.
         Starting Enable support fo…l executable binary formats...
         Starting Set console font and keymap...
         Starting Helper to synchronize boot up for ifupdown...
         Starting Create Volatile Files and Directories...
         Starting Rule-based Manage…for Device Events and Files...
[  OK  ] Finished Enable support fo…nal executable binary formats.
[  OK  ] Finished Set console font and keymap.
[  OK  ] Finished Helper to synchronize boot up for ifupdown.
[  OK  ] Finished Create Volatile Files and Directories.
[  OK  ] Started Entropy Daemon based on the HAVEGE algorithm.
         Starting Raise network interfaces...
         Starting Network Time Synchronization...
         Starting Record System Boot/Shutdown in UTMP...
[  OK  ] Started Rule-based Manager for Device Events and Files.
         Starting Network Configuration...
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Started Network Configuration.
[  OK  ] Found device /dev/ttyPS0.
[  OK  ] Reached target Hardware activated USB gadget.
[   11.132575] zocl-drm axi:zyxclmm_drm: error -ENXIO: IRQ index 8 not found
         Starting Wait for Network to be Configured...
         Starting Network Name Resolution...
[  OK  ] Started Network Time Synchronization.
[  OK  ] Finished Wait for Network to be Configured.
[  OK  ] Finished Raise network interfaces.
[  OK  ] Reached target System Initialization.
[  OK  ] Started resolvconf-pull-resolved.path.
[  OK  ] Started Trigger to poll fo…y enabled on GCP LTS non-pro).
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started Ubuntu Advantage Timer for running repeated jobs.
[  OK  ] Reached target Path Units.
[  OK  ] Reached target System Time Set.
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Started Daily dpkg database backup timer.
[  OK  ] Started Periodic ext4 Onli…ata Check for All Filesystems.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily man-db regeneration.
[  OK  ] Started Message of the Day.
[  OK  ] Reached target Timer Units.
[  OK  ] Listening on D-Bus System Message Bus Socket.
         Starting Socket activation for snappy daemon...
[  OK  ] Listening on Load/Save RF …itch Status /dev/rfkill Watch.
[  OK  ] Listening on UUID daemon activation socket.
[  OK  ] Listening on Socket activation for snappy daemon.
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
         Starting LSB: automatic crash report generation...
         Starting Executing boot.py from the boot partition...
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Save initial kernel messages after boot.
         Starting Remove Stale Onli…t4 Metadata Check Snapshots...
[  OK  ] Started ISC DHCP IPv6 server.
         Starting Jupyter Notebook Server...
         Starting LSB: Load kernel …d to enable cpufreq scaling...
         Starting Dispatcher daemon for systemd-networkd...
         Starting Samba NMB Daemon...
         Starting Resize Filesystem on SD card...
         Starting resolvconf-pull-resolved.service...
         Starting System Logging Service...
         Starting Snap Daemon...
         Starting OpenBSD Secure Shell server...
         Starting User Login Management...
         Starting Permit User Sessions...
         Starting USB Gadget for Networking...
[  OK  ] Finished Resize Filesystem on SD card.
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started PYNQ X11 Server.
[  OK  ] Started Serial Getty on ttyPS0.
         Starting Set console scheme...
[  OK  ] Started LSB: automatic crash report generation.
[  OK  ] Finished Set console scheme.
[  OK  ] Created slice Slice /system/getty.
[  OK  ] Started Getty on tty1.
[  OK  ] Found device /dev/ttyGS0.
[  OK  ] Started Serial Getty on ttyGS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Finished resolvconf-pull-resolved.service.
[  OK  ] Finished USB Gadget for Networking.
[  OK  ] Started ISC DHCP IPv4 server.
[  OK  ] Started System Logging Service.
[  OK  ] Started User Login Management.
[  OK  ] Started Unattended Upgrades Shutdown.
[  OK  ] Started LSB: Load kernel m…ded to enable cpufreq scaling.
         Starting LSB: set CPUFreq kernel parameters...
[  OK  ] Started LSB: set CPUFreq kernel parameters.
[  OK  ] Started OpenBSD Secure Shell server.
[  OK  ] Created slice User Slice of UID 0.
         Starting User Runtime Directory /run/user/0...
[  OK  ] Finished User Runtime Directory /run/user/0.
         Starting User Manager for UID 0...
[  OK  ] Started Dispatcher daemon for systemd-networkd.
[  OK  ] Started Snap Daemon.
         Starting Wait until snapd is fully seeded...
         Starting Time & Date Service...
[  OK  ] Started Samba NMB Daemon.
         Starting Samba SMB Daemon...
[  OK  ] Started User Manager for UID 0.
[  OK  ] Started Session c1 of User root.
[  OK  ] Started Time & Date Service.

PYNQ Linux, based on Ubuntu 22.04 pynq ttyPS0

pynq login: xilinx (automatic login)

Welcome to PYNQ Linux, based on Ubuntu 22.04 (GNU/Linux 6.6.10-xilinx-v2024.1-g11d515574674 aarch64)

Last login: Thu May 21 07:35:54 UTC 2037 on ttyGS0
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

xilinx@pynq:~$
```

---------------------------------------
<p class="copyright">Copyright&copy; 2022 Advanced Micro Devices</p>