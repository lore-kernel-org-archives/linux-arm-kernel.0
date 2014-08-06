From: nicolas.derouineau@vitec.com (Nicolas Derouineau)
Date: Wed, 6 Aug 2014 16:01:57 +0000
Subject: CPUIdle Armada 370
In-Reply-To: <53E24D2A.50706@free-electrons.com>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com>
 <53E249A1.900@free-electrons.com>,<53E24D2A.50706@free-electrons.com>
Message-ID: <1407340917231.68970@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok,
So here is the log of the error(using the previous config file)


NAND read: device 0 offset 0x240000, size 0x600000
 6291456 bytes read: OK
## Booting kernel from Legacy Image at 02000000 ...
   Image Name:   Linux-3.16.0-next-20140805-dirty
   Created:      2014-08-06  15:56:06 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2939920 Bytes = 2.8 MiB
   Load Address: 00080000
   Entry Point:  00080000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x01000000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 00ffa000, end 00fff8a6 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.0-next-20140805-dirty (nde at nde-OptiPlex-980) (gcc version 4.6.4 (Linaro GCC branch-4.6.4. Marvell GCC release 201308-2123.0cc69bb4 64K MAXPAGESIZE ALIGN) ) #13 Wed Aug 6 14
[    0.000000] CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Vitec VMR-1404 (Marvell Armada 370 based)
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 48768
[    0.000000] Kernel command line: console=ttyS0,115200 mtdparts=pxa3xx_nand-0:1m(u-boot),128k(u-boot_env),128k(u-boot_env_alt),1m(u-boot_factory),6m(a_kernel),128k(a_dtb),150m(a_rootfs),6m(a_bitstream),6M
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 188356K/196608K available (4425K kernel code, 268K rwdata, 1244K rodata, 277K init, 160K bss, 8252K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xcc800000 - 0xff000000   ( 808 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcc000000   ( 192 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05917bc   (5670 kB)
[    0.000000]       .init : 0xc0592000 - 0xc05d76ec   ( 278 kB)
[    0.000000]       .data : 0xc05d8000 - 0xc061b220   ( 269 kB)
[    0.000000]        .bss : 0xc061b220 - 0xc06435a8   ( 161 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: device tree omits to specify unified cache
[    0.000000] L2C: DT/platform modifies aux control register: 0x12086302 -> 0x1a086302
[    0.000000] Aurora cache controller enabled, 4 ways, 256 kB
[    0.000000] Aurora: CACHE_ID 0x00000100, AUX_CTRL 0x1a086302
[    0.000017] sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 257698047939ns
[    0.000331] Console: colour dummy device 80x30
[    0.000354] Calibrating delay loop... 795.44 BogoMIPS (lpj=3977216)
[    0.040102] pid_max: default: 32768 minimum: 301
[    0.040216] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.040229] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.040665] CPU: Testing write buffer coherency: ok
[    0.040697] ftrace: allocating 15101 entries in 45 pages
[    0.073547] Setting up static identity map for 0x3ff248 - 0x3ff2a0
[    0.073922] mvebu-soc-id: MVEBU SoC ID=0x6707, Rev=0x1
[    0.074087] mvebu-pmsu: Initializing Power Management Service Unit
[    0.076381] devtmpfs: initialized
[    0.076940] VFP support v0.3: implementor 56 architecture 2 part 20 variant 9 rev 6
[    0.077649] pinctrl core: initialized pinctrl subsystem
[    0.080625] NET: Registered protocol family 16
[    0.081039] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.081818] cpuidle: using governor ladder
[    0.081836] cpuidle: using governor menu
[    0.086494] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.093174] vgaarb: loaded
[    0.093507] SCSI subsystem initialized
[    0.093946] Advanced Linux Sound Architecture Driver Initialized.
[    0.094643] Switched to clocksource armada_370_xp_clocksource
[    0.116009] NET: Registered protocol family 2
[    0.116785] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.116815] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.116837] TCP: Hash tables configured (established 2048 bind 2048)
[    0.116889] TCP: reno registered
[    0.116901] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.116918] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.117067] NET: Registered protocol family 1
[    0.117533] RPC: Registered named UNIX socket transport module.
[    0.117545] RPC: Registered udp transport module.
[    0.117552] RPC: Registered tcp transport module.
[    0.117559] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.118904] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.120480] msgmni has been set to 367
[    0.122039] io scheduler noop registered
[    0.122057] io scheduler deadline registered
[    0.122085] io scheduler cfq registered (default)
[    0.122917] armada-370-pinctrl f1018000.pinctrl: registered pinctrl driver
[    0.123461] irq: Cannot allocate irq_descs @ IRQ42, assuming pre-allocated
[    0.123828] irq: Cannot allocate irq_descs @ IRQ74, assuming pre-allocated
[    0.124062] irq: Cannot allocate irq_descs @ IRQ106, assuming pre-allocated
[    0.124266] mv_xor f1060800.xor: Marvell shared XOR driver
[    0.154760] mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
[    0.194748] mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
[    0.194917] mv_xor f1060900.xor: Marvell shared XOR driver
[    0.234747] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.274747] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    0.331112] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.333089] console [ttyS0] disabled
[    0.353137] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 20, base_baud = 12500000) is a 16550A
[    0.869567] console [ttyS0] enabled
[    0.893959] f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 21, base_baud = 12500000) is a 16550A
[    0.904036] pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
[    0.912354] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    0.918750] nand: Micron MT29F4G08ABADAWP
[    0.922771] nand: 512MiB, SLC, page size: 2048, OOB size: 64
[    0.928462] pxa3xx-nand f10d0000.nand: ECC strength 16, ECC step size 2048
[    0.937097] Bad block table found at page 262080, version 0x01
[    0.943472] Bad block table found at page 262016, version 0x01
[    0.949822] 17 cmdlinepart partitions found on MTD device pxa3xx_nand-0
[    0.956474] Creating 17 MTD partitions on "pxa3xx_nand-0":
[    0.961978] 0x000000000000-0x000000100000 : "u-boot"
[    0.968266] 0x000000100000-0x000000120000 : "u-boot_env"
[    0.974008] 0x000000120000-0x000000140000 : "u-boot_env_alt"
[    0.980396] 0x000000140000-0x000000240000 : "u-boot_factory"
[    0.986400] 0x000000240000-0x000000840000 : "a_kernel"
[    0.992259] 0x000000840000-0x000000860000 : "a_dtb"
[    0.997483] 0x000000860000-0x000009e60000 : "a_rootfs"
[    1.003735] 0x000009e60000-0x00000a460000 : "a_bitstream"
[    1.009497] 0x00000a460000-0x00000aa60000 : "b_kernel"
[    1.015377] 0x00000aa60000-0x00000aa80000 : "b_dtb"
[    1.020547] 0x00000aa80000-0x000014080000 : "b_rootfs"
[    1.026881] 0x000014080000-0x000014680000 : "b_bitstream"
[    1.032604] 0x000014680000-0x000014c80000 : "factory_kernel"
[    1.038997] 0x000014c80000-0x000014ca0000 : "factory_dtb"
[    1.044732] 0x000014ca0000-0x00001e2a0000 : "factory_rootfs"
[    1.051555] 0x00001e2a0000-0x00001e8a0000 : "factory_bitstream"
[    1.057831] 0x00001e8a0000-0x000020000000 : "data"
[    1.064687] libphy: orion_mdio_bus: probed
[    1.110126] mvneta f1074000.ethernet eth0: Using hardware mac address 00:50:43:02:02:00
[    1.118281] i2c /dev entries driver
[    1.136227] orion_wdt: Initial timeout 257 sec
[    1.142453] TCP: cubic registered
[    1.145826] NET: Registered protocol family 17
[    1.150411] ThumbEE CPU extension supported.
[    1.157092] UBI: attaching mtd6 to ubi0
[    1.355852] UBI: scanning is finished
[    1.372752] UBI: volume 0 ("rootfs") re-sized from 194 to 1116 LEBs
[    1.379775] UBI: attached mtd6 (name "a_rootfs", size 150 MiB) to ubi0
[    1.386349] UBI: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    1.393153] UBI: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    1.399881] UBI: VID header offset: 2048 (aligned 2048), data offset: 4096
[    1.406781] UBI: good PEBs: 1200, bad PEBs: 0, corrupted PEBs: 0
[    1.412801] UBI: user volume: 1, internal volumes: 1, max. volumes count: 128
[    1.419964] UBI: max/mean erase counter: 1/0, WL threshold: 4096, image sequence number: 1052416919
[    1.429039] UBI: available PEBs: 0, total reserved PEBs: 1200, PEBs reserved for bad PEB handling: 80
[    1.440341] UBI: background thread "ubi_bgt0d" started, PID 926
[    1.600876] random: nonblocking pool is initialized
[    3.272987] Unable to handle kernel paging request at virtual address cc921000
[    3.280230] pgd = c0004000
[    3.282943] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    3.289263] Internal error: Oops: 807 [#1] ARM
[    3.293716] Modules linked in:
[    3.296792] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    3.303770] task: cb0b0090 ti: cc920000 task.ti: 613d4e4f
[    3.309187] PC is at __dabt_svc+0xc/0x60
[    3.313128] LR is at do_translation_fault+0xac/0xb4
[    3.318020] pc : [<c001372c>]    lr : [<c001c28c>]    psr: 40000193
[    3.318020] sp : cc920fd4  ip : cc922070  fp : cc92206c
[    3.329520] r10: 00000005  r9 : c0607748  r8 : c0612be4
[    3.334756] r7 : cc922138  r6 : 06000145  r5 : c05e4a7c  r4 : 00000005
[    3.341297] r3 : 06000145  r2 : cc922138  r1 : 00000005  r0 : c061b3cc
[    3.347838] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    3.355249] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    3.361007] Process  (pid: 0, stack limit = 0x613d5097)
[    3.366244] Stack: (0xcc920fd4 to 0x613d6e4f)
[    3.370620] Unable to handle kernel paging request at virtual address cc921000
[    3.377856] pgd = c0004000
[    3.380569] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    3.386884] Internal error: Oops: 7 [#2] ARM
[    3.391161] Modules linked in:
[    3.394235] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    3.401212] task: cb0b0090 ti: cc920000 task.ti: 613d4e4f
[    3.406625] PC is at unwind_frame+0x460/0x64c
[    3.410994] LR is at unwind_frame+0x428/0x64c
[    3.415363] pc : [<c0015e4c>]    lr : [<c0015e14>]    psr: 60000193
[    3.415363] sp : cc920d28  ip : 00000fff  fp : cc920dbc
[    3.426863] r10: cc920fd4  r9 : 60000193  r8 : 00000807
[    3.432100] r7 : cc920dc8  r6 : cc922000  r5 : c06140a8  r4 : cc921000
[    3.438641] r3 : 0000001f  r2 : cc920d58  r1 : cc92206c  r0 : 00000000
[    3.445183] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    3.452593] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    3.458352] Process  (pid: 0, stack limit = 0x613d5097)
[    3.463588] Stack: (0xcc920d28 to 0x613d6e4f)
[    3.467962] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    3.475998] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    3.483334] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    3.491189] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    3.500088] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    3.507766] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    3.515176] Exception stack(0xcc920f88 to 0xcc920fd0)
[    3.520245] 0f80:                   c061b3cc 00000005 cc922138 06000145 00000005 c05e4a7c
[    3.528446] 0fa0: 06000145 cc922138 c0612be4 c0607748 00000005 cc92206c cc922070 cc920fd4
[    3.536642] 0fc0: c001c28c c001372c 40000193 ffffffff
[    3.541711] [<c0013758>] (__dabt_svc) from [<c001372c>] (__dabt_svc+0xc/0x60)
[    3.548863] Unable to handle kernel paging request at virtual address cc921000
[    3.556099] pgd = c0004000
[    3.558811] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    3.565126] Internal error: Oops: 7 [#3] ARM
[    3.569403] Modules linked in:
[    3.572478] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    3.579455] task: cb0b0090 ti: cc920000 task.ti: 613d4e4f
[    3.584867] PC is at unwind_frame+0x460/0x64c
[    3.589236] LR is at unwind_frame+0x428/0x64c
[    3.593606] pc : [<c0015e4c>]    lr : [<c0015e14>]    psr: 60000193
[    3.593606] sp : cc920a80  ip : 00000fff  fp : cc920b14
[    3.605106] r10: cc920fd4  r9 : 60000193  r8 : 00000007
[    3.610342] r7 : cc920b20  r6 : cc922000  r5 : c06140a8  r4 : cc921000
[    3.616883] r3 : 0000001f  r2 : cc920ab0  r1 : cc92206c  r0 : 00000000
[    3.623425] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    3.630837] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    3.636594] Process  (pid: 0, stack limit = 0x613d5097)
[    3.641829] Stack: (0xcc920a80 to 0x613d6e4f)
[    3.646203] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    3.654230] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    3.661563] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    3.669417] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    3.678314] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    3.685992] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    3.693402] Exception stack(0xcc920ce0 to 0xcc920d28)
[    3.698471] 0ce0: 00000000 cc92206c cc920d58 0000001f cc921000 c06140a8 cc922000 cc920dc8
[    3.706672] 0d00: 00000807 60000193 cc920fd4 cc920dbc 00000fff cc920d28 c0015e14 c0015e4c
[    3.714865] 0d20: 60000193 ffffffff
[    3.718368] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    3.725959] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    3.733986] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    3.741318] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    3.749173] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    3.758069] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    3.765746] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    3.773156] Exception stack(0xcc920f88 to 0xcc920fd0)
[    3.778223] 0f80:                   c061b3cc 00000005 cc922138 06000145 00000005 c05e4a7c
[    3.786424] 0fa0: 06000145 cc922138 c0612be4 c0607748 00000005 cc92206c cc922070 cc920fd4
[    3.794620] 0fc0: c001c28c c001372c 40000193 ffffffff
[    3.799688] [<c0013758>] (__dabt_svc) from [<c001372c>] (__dabt_svc+0xc/0x60)
[    3.806839] Unable to handle kernel paging request at virtual address cc921000
[    3.814075] pgd = c0004000
[    3.816788] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    3.823102] Internal error: Oops: 7 [#4] ARM
[    3.827379] Modules linked in:
[    3.830455] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    3.837432] task: cb0b0090 ti: cc920000 task.ti: 613d4e4f
[    3.842842] PC is at unwind_frame+0x460/0x64c
[    3.847210] LR is at unwind_frame+0x428/0x64c
[    3.851579] pc : [<c0015e4c>]    lr : [<c0015e14>]    psr: 60000193
[    3.851579] sp : cc9207d8  ip : 00000fff  fp : cc92086c
[    3.863080] r10: cc920fd4  r9 : 60000193  r8 : 00000007
[    3.868317] r7 : cc920878  r6 : cc922000  r5 : c06140a8  r4 : cc921000
[    3.874859] r3 : 0000001f  r2 : cc920808  r1 : cc92206c  r0 : 00000000
[    3.881399] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    3.888810] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    3.894568] Process 1 (pid: 0, stack limit = 0x613d5097)
[    3.899891] Stack: (0xcc9207d8 to 0x613d6e4f)
[    3.904265] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    3.912292] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    3.919624] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    3.927479] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    3.936374] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    3.944051] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    3.951461] Exception stack(0xcc920a38 to 0xcc920a80)
[    3.956525] 0a20:                                                       00000000 cc92206c
[    3.964725] 0a40: cc920ab0 0000001f cc921000 c06140a8 cc922000 cc920b20 00000007 60000193
[    3.972925] 0a60: cc920fd4 cc920b14 00000fff cc920a80 c0015e14 c0015e4c 60000193 ffffffff
[    3.981125] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    3.988716] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    3.996743] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.004075] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.011929] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.020825] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.028502] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.035912] Exception stack(0xcc920ce0 to 0xcc920d28)
[    4.040981] 0ce0: 00000000 cc92206c cc920d58 0000001f cc921000 c06140a8 cc922000 cc920dc8
[    4.049182] 0d00: 00000807 60000193 cc920fd4 cc920dbc 00000fff cc920d28 c0015e14 c0015e4c
[    4.057375] 0d20: 60000193 ffffffff
[    4.060879] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    4.068470] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.076497] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.083830] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.091684] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.100580] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.108257] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.115667] Exception stack(0xcc920f88 to 0xcc920fd0)
[    4.120734] 0f80:                   c061b3cc 00000005 cc922138 06000145 00000005 c05e4a7c
[    4.128934] 0fa0: 06000145 cc922138 c0612be4 c0607748 00000005 cc92206c cc922070 cc920fd4
[    4.137130] 0fc0: c001c28c c001372c 40000193 ffffffff
[    4.142198] [<c0013758>] (__dabt_svc) from [<c001372c>] (__dabt_svc+0xc/0x60)
[    4.149349] Unable to handle kernel paging request at virtual address cc921000
[    4.156585] pgd = c0004000
[    4.159297] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    4.165611] Internal error: Oops: 7 [#5] ARM
[    4.169889] Modules linked in:
[    4.172964] CPU: 0 PID: 4 Comm: `????@???O?$??0? Not tainted 3.16.0-next-20140805-dirty #13
[    4.181683] Unable to handle kernel NULL pointer dereference at virtual address 0000014a
[    4.189787] pgd = c0004000
[    4.192500] [0000014a] *pgd=00000000
[    4.196094] Internal error: Oops: 5 [#6] ARM
[    4.200371] Modules linked in:
[    4.203446] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    4.210423] task: cb0b6090 ti: cc91e000 task.ti: 613d4e4f
[    4.215835] PC is at do_page_fault+0x3c/0x3a8
[    4.220205] LR is at do_translation_fault+0xac/0xb4
[    4.225096] pc : [<c001bddc>]    lr : [<c001c28c>]    psr: 00000193
[    4.225096] sp : cc920078  ip : cc920110  fp : cc92010c
[    4.236596] r10: 00000005  r9 : 60000193  r8 : 00000004
[    4.241833] r7 : 00000006  r6 : 00000012  r5 : c05e4a7c  r4 : cc9201d8
[    4.248374] r3 : cc920000  r2 : 60000193  r1 : 00000005  r0 : 00000012
[    4.254916] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    4.262327] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    4.268085] Process  (pid: 0, stack limit = 0x613d5097)
[    4.273320] Stack: (0xcc920078 to 0x613d6e4f)
[    4.277697] [<c001bddc>] (do_page_fault) from [<c001c28c>] (do_translation_fault+0xac/0xb4)
[    4.286072] [<c001c28c>] (do_translation_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.294359] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.301769] Exception stack(0xcc9201d8 to 0xcc920220)
[    4.306833] 01c0:                                                       c04bed9c 00000006
[    4.315033] 01e0: cc920278 cc920000 c05e29b3 c04bed9c c061bb18 cb0b0090 00000004 60000193
[    4.323234] 0200: c05e3c78 cc920274 cc920278 cc920220 c00557e0 c003c664 60000193 ffffffff
[    4.331441] [<c0013758>] (__dabt_svc) from [<c003c664>] (print_worker_info+0x18/0x160)
[    4.339387] [<c003c664>] (print_worker_info) from [<c00557e0>] (dump_stack_print_info+0xa0/0xd4)
[    4.348197] [<c00557e0>] (dump_stack_print_info) from [<c0055834>] (show_regs_print_info+0x20/0x50)
[    4.357270] [<c0055834>] (show_regs_print_info) from [<c0010018>] (__show_regs+0x28/0x1e4)
[    4.365559] [<c0010018>] (__show_regs) from [<c0012df8>] (die+0x190/0x244)
[    4.372457] [<c0012df8>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.380312] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.389208] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.396886] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.404296] Exception stack(0xcc9204e8 to 0xcc920530)
[    4.409364] 04e0:                   00000000 cc92206c cc920560 0000001f cc921000 c06140a8
[    4.417565] 0500: cc922000 cc9205d0 00000007 60000193 cc920fd4 cc9205c4 00000fff cc920530
[    4.425760] 0520: c0015e14 c0015e4c 60000193 ffffffff
[    4.430829] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    4.438421] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.446448] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.453781] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.461635] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.470531] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.478208] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.485618] Exception stack(0xcc920790 to 0xcc9207d8)
[    4.490684] 0780:                                     00000000 cc92206c cc920808 0000001f
[    4.498884] 07a0: cc921000 c06140a8 cc922000 cc920878 00000007 60000193 cc920fd4 cc92086c
[    4.507082] 07c0: 00000fff cc9207d8 c0015e14 c0015e4c 60000193 ffffffff
[    4.513716] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    4.521308] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.529335] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.536666] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.544520] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.553417] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.561095] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.568506] Exception stack(0xcc920a38 to 0xcc920a80)
[    4.573570] 0a20:                                                       00000000 cc92206c
[    4.581770] 0a40: cc920ab0 0000001f cc921000 c06140a8 cc922000 cc920b20 00000007 60000193
[    4.589970] 0a60: cc920fd4 cc920b14 00000fff cc920a80 c0015e14 c0015e4c 60000193 ffffffff
[    4.598171] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    4.605763] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.613790] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.621122] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.628976] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.637872] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.645550] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.652961] Exception stack(0xcc920ce0 to 0xcc920d28)
[    4.658030] 0ce0: 00000000 cc92206c cc920d58 0000001f cc921000 c06140a8 cc922000 cc920dc8
[    4.666230] 0d00: 00000807 60000193 cc920fd4 cc920dbc 00000fff cc920d28 c0015e14 c0015e4c
[    4.674425] 0d20: 60000193 ffffffff
[    4.677928] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    4.685519] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.693546] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.700877] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.708730] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.717627] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.725305] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    4.732714] Exception stack(0xcc920f88 to 0xcc920fd0)
[    4.737782] 0f80:                   c061b3cc 00000005 cc922138 06000145 00000005 c05e4a7c
[    4.745981] 0fa0: 06000145 cc922138 c0612be4 c0607748 00000005 cc92206c cc922070 cc920fd4
[    4.754177] 0fc0: c001c28c c001372c 40000193 ffffffff
[    4.759245] [<c0013758>] (__dabt_svc) from [<c001372c>] (__dabt_svc+0xc/0x60)
[    4.766396] Unable to handle kernel paging request at virtual address cc921000
[    4.773631] pgd = c0004000
[    4.776344] [cc921000] *pgd=0b805811, *pte=00000000, *ppte=00000000
[    4.782659] Internal error: Oops: 7 [#7] ARM
[    4.786936] Modules linked in:
[    4.790011] CPU: 0 PID: 0 Comm:  Not tainted 3.16.0-next-20140805-dirty #13
[    4.796987] task: cb0b6090 ti: cc91e000 task.ti: 613d4e4f
[    4.802399] PC is at unwind_frame+0x460/0x64c
[    4.806767] LR is at unwind_frame+0x428/0x64c
[    4.811137] pc : [<c0015e4c>]    lr : [<c0015e14>]    psr: 60000193
[    4.811137] sp : cc91fdb0  ip : 00000fff  fp : cc91fe44
[    4.822638] r10: cc920fd4  r9 : 60000193  r8 : 00000005
[    4.827874] r7 : cc91fe50  r6 : cc922000  r5 : c06140a8  r4 : cc921000
[    4.834415] r3 : 0000001f  r2 : cc91fde0  r1 : cc92206c  r0 : 00000000
[    4.840956] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    4.848367] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    4.854125] Process  (pid: 0, stack limit = 0x613d5097)
[    4.859361] Stack: (0xcc91fdb0 to 0x613d6e4f)
[    4.863735] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    4.871764] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    4.879096] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    4.886950] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    4.895847] [<c001bf68>] (do_page_fault) from [<c001c28c>] (do_translation_fault+0xac/0xb4)
[    4.904222] [<c001c28c>] (do_translation_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    4.912509] Code: e3130001 0a000003 e3500000 1a000042 (e4941004) 
[    4.918616] ---[ end trace 5a919dbb7acec3b6 ]---
[    4.923243] Kernel panic - not syncing: Fatal exception in interrupt
[    4.929610] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
[    4.936779] Unable to handle kernel NULL pointer dereference at virtual address 000000e0
[    4.944884] pgd = c0004000
[    4.947597] [000000e0] *pgd=00000000
[    4.951191] Internal error: Oops: 5 [#8] ARM
[    4.955468] Modules linked in:
[    4.958544] CPU: 0 PID: 0 Comm:  Tainted: G      D        3.16.0-next-20140805-dirty #13
[    4.966652] task: cb0b6090 ti: cc91e000 task.ti: 613d4e4f
[    4.972069] PC is at account_system_time+0x6c/0x1d8
[    4.976960] LR is at account_process_tick+0x44/0x90
[    4.981852] pc : [<c0049448>]    lr : [<c0049764>]    psr: 20000193
[    4.981852] sp : cc91f958  ip : cc91e000  fp : cc91f974
[    4.993352] r10: c0623540  r9 : c0623680  r8 : c05e9380
[    4.998588] r7 : 00000001  r6 : 00000000  r5 : 00000001  r4 : 00000004
[    5.005128] r3 : 00000001  r2 : 00000001  r1 : 00000000  r0 : cb0b6090
[    5.011670] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    5.019080] Control: 10c5387d  Table: 00004019  DAC: 00000015
[    5.024838] Process  (pid: 0, stack limit = 0x613d5097)
[    5.030073] Stack: (0xcc91f958 to 0x613d6e4f)
[    5.034449] [<c0049448>] (account_system_time) from [<c0049764>] (account_process_tick+0x44/0x90)
[    5.043353] [<c0049764>] (account_process_tick) from [<c006174c>] (update_process_times+0x34/0x74)
[    5.052345] [<c006174c>] (update_process_times) from [<c006fa98>] (tick_sched_timer+0x64/0x23c)
[    5.061070] [<c006fa98>] (tick_sched_timer) from [<c00622c8>] (__run_hrtimer+0x98/0x2bc)
[    5.069185] [<c00622c8>] (__run_hrtimer) from [<c0062b8c>] (hrtimer_interrupt+0x110/0x2f8)
[    5.077482] [<c0062b8c>] (hrtimer_interrupt) from [<c02f5df8>] (armada_370_xp_timer_interrupt+0x4c/0x60)
[    5.086994] [<c02f5df8>] (armada_370_xp_timer_interrupt) from [<c0059528>] (handle_percpu_devid_irq+0x88/0x1b4)
[    5.097110] [<c0059528>] (handle_percpu_devid_irq) from [<c0055930>] (generic_handle_irq+0x34/0x40)
[    5.106182] [<c0055930>] (generic_handle_irq) from [<c000fcd8>] (handle_IRQ+0x40/0x98)
[    5.114122] [<c000fcd8>] (handle_IRQ) from [<c00085f8>] (armada_370_xp_handle_irq+0x58/0x68)
[    5.122583] [<c00085f8>] (armada_370_xp_handle_irq) from [<c00137c0>] (__irq_svc+0x40/0x50)
[    5.130951] Exception stack(0xcc91fb48 to 0xcc91fb90)
[    5.136019] fb40:                   00000041 cc91fb00 cb0b6122 cc91e000 00000000 00000000
[    5.144219] fb60: c061b6e8 cb0b6090 00000007 60000193 c061b6e8 cc91fbc4 cc91fab0 cc91fb90
[    5.152415] fb80: c0053d94 c03f92c8 60000113 ffffffff
[    5.157485] [<c00137c0>] (__irq_svc) from [<c03f92c8>] (panic+0x190/0x20c)
[    5.164382] [<c03f92c8>] (panic) from [<c0012dec>] (die+0x184/0x244)
[    5.170757] [<c0012dec>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    5.178613] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    5.187509] [<c001bf68>] (do_page_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    5.195187] [<c0008470>] (do_DataAbort) from [<c0013758>] (__dabt_svc+0x38/0x60)
[    5.202597] Exception stack(0xcc91fd68 to 0xcc91fdb0)
[    5.207665] fd60:                   00000000 cc92206c cc91fde0 0000001f cc921000 c06140a8
[    5.215865] fd80: cc922000 cc91fe50 00000005 60000193 cc920fd4 cc91fe44 00000fff cc91fdb0
[    5.224061] fda0: c0015e14 c0015e4c 60000193 ffffffff
[    5.229130] [<c0013758>] (__dabt_svc) from [<c0015e4c>] (unwind_frame+0x460/0x64c)
[    5.236722] [<c0015e4c>] (unwind_frame) from [<c00160e8>] (unwind_backtrace+0xb0/0x150)
[    5.244750] [<c00160e8>] (unwind_backtrace) from [<c0012e68>] (die+0x200/0x244)
[    5.252081] [<c0012e68>] (die) from [<c03f9118>] (__do_kernel_fault.part.8+0x64/0x84)
[    5.259935] [<c03f9118>] (__do_kernel_fault.part.8) from [<c001bf68>] (do_page_fault+0x1c8/0x3a8)
[    5.268832] [<c001bf68>] (do_page_fault) from [<c001c28c>] (do_translation_fault+0xac/0xb4)
[    5.277207] [<c001c28c>] (do_translation_fault) from [<c0008470>] (do_DataAbort+0x44/0xa8)
[    5.285493] Code: e0855002 e0863003 e58051fc e5803204 (e59130e0) 
[    5.291598] ---[ end trace 5a919dbb7acec3b7 ]---
[    5.296225] Kernel panic - not syncing: Fatal exception in interrupt
[    5.302592] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
________________________________________
De : Gregory CLEMENT <gregory.clement@free-electrons.com>
Envoy? : mercredi 6 ao?t 2014 17:43
? : Nicolas Derouineau; linux-arm-kernel at lists.infradead.org
Cc : Thomas Petazzoni; Simon Boulay
Objet : Re: CPUIdle Armada 370

Hi Nicolas,

[..]

>> On 06/08/2014 16:01, Nicolas Derouineau wrote:
>>> Hello,
>>> I am currently trying to use the CPUIdle driver provided by linux-next (or by the patch here https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.16/cpuidle-v3).
>>
>> I have just tested using next-20140806 and mvebu_v7_defconfig.
>> And it worked well on a mirabox using the Armada 370 SoC.
>>
>>>
>>> Everything runs fine as long as I don't select the CPU driver for the ARMADA Family. When I do, at boottime, the program is entering the __cpu_suspend save function and then get lost in it and that turns into a kernel panic. I have already made a post about this on the ARM Community Forum (http://community.arm.com/thread/6326).
>>>
>>> The "faulty" configuration file is attached to this email.
>>
>> Now I will try with this configuration
>
> Using your configuration file I didn't reproduce your issue.
> And according to the stat given by linux the kernel spent a lot
> of time in idle:
>
> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/time
> 338822284
>
>
> Could you try again with next-20140806?

Also could you send your full boot log until the crash
it may help us.

Thanks,

Gregory

--
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
