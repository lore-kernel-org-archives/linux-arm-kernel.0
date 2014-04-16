From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 16 Apr 2014 09:55:16 +0400
Subject: =?UTF-8?B?UmU6IFVTQiBPVEcgc3VwcG9ydCBvbiBteDI3cGRr?=
In-Reply-To: <2394b8be344646358b23a105c8725961@BL2PR03MB226.namprd03.prod.outlook.com>
References: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
 <2394b8be344646358b23a105c8725961@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <1397627716.685483508@f399.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 16 Apr 2014 03:23:54 +0000 ?? Peter Chen <Peter.Chen@freescale.com>:
> > Hi,
> > I am trying to add USBOTG support to mx27pdk with the following dts patch:
...
> I cced chris who has imx27 hardware.

Loading OS arm Linux zImage '/dev/nor0.kernel'
using internal devicetree
commandline: console=ttymxc0,115200n8 earlyprintk  root=/dev/mtdblock3 ro
booting kernel with devicetree

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.15.0-rc1-next-20140415-dirty (shc at shc.zet) (gcc version 4.7.3 (GCC) ) #11 PREEMPT Wed Apr 16 09:40:14 MSK 2014
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine model: Phytec pcm970
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttymxc0,115200n8 earlyprintk  root=/dev/mtdblock3 ro
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 123364K/131072K available (4601K kernel code, 256K rwdata, 1244K rodata, 170K init, 143K bss, 7708K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
      .text : 0xc0008000 - 0xc05bd8c0   (5847 kB)
      .init : 0xc05be000 - 0xc05e8970   ( 171 kB)
      .data : 0xc05ea000 - 0xc062a260   ( 257 kB)
       .bss : 0xc062a26c - 0xc064e104   ( 144 kB)
Preemptible hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
MXC IRQ initialized
Switching to timer-based delay loop
sched_clock: 32 bits at 14MHz, resolution 67ns, wraps every 290636879804ns
CPU identified as i.MX27, silicon rev 2.1
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 29.55 BogoMIPS (lpj=147777)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xa045f2c8 - 0xa045f328
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor ladder
cpuidle: using governor menu
imx27-pinctrl 10015000.iomuxc: initialized IMX pinctrl driver
3V3: 3300 mV 
5V0: 5000 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
platform 0.usbphy: Driver usb_phy_gen_xceiv requests probe deferral
platform 2.usbphy: Driver usb_phy_gen_xceiv requests probe deferral
i2c i2c-0: IMX I2C adapter registered
i2c i2c-1: IMX I2C adapter registered
Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource mxc_timer1
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -1, 3072 bytes)
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 240
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered (default)
imx-weim d8002000.weim: Driver registered.
imx-fb 10021000.fb: i.MX Framebuffer driver
Console: switching to colour frame buffer device 30x40
Serial: IMX driver
1000a000.serial: ttymxc0 at MMIO 0x1000a000 (irq = 36, base_baud = 923611) is a IMX
console [ttymxc0] enabled
bootconsole [earlycon0] disabled
1000b000.serial: ttymxc1 at MMIO 0x1000b000 (irq = 35, base_baud = 923611) is a IMX
[drm] Initialized drm 1.1.0 20060810
at24 1-0052: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x00891c
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
4 ofpart partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000080000 : "boot"
0x000000080000-0x0000000a0000 : "env"
0x0000000a0000-0x0000004a0000 : "kernel"
0x0000004a0000-0x000002000000 : "root"
nand: device found, Manufacturer ID: 0x20, Chip ID: 0x36
nand: ST Micro NAND 64MiB 1,8V 8-bit
nand: 64MiB, SLC, page size: 512, OOB size: 16
Bad block table found at page 131040, version 0x01
Bad block table found at page 131008, version 0x01
4 ofpart partitions found on MTD device mxc_nand
Creating 4 MTD partitions on "mxc_nand":
0x000000000000-0x000000080000 : "boot"
0x000000080000-0x0000000a0000 : "env"
0x0000000a0000-0x0000004a0000 : "kernel"
0x0000004a0000-0x000004000000 : "root"
mc13xxx spi0.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
SW1A: 1200 <--> 1500 mV at 1450 mV 
SW2A: 1800 mV 
SW3: 5000 mV 
VAUDIO: 2775 mV 
VIOLO: 1800 mV 
VIOHI: 2775 mV 
VGEN: 1500 mV 
VCAM: 2800 mV 
VRF1: 2775 mV 
VRF2: 2775 mV 
VMMC1: 1600 <--> 3000 mV at 2900 mV 
GPO1: 3100 mV 
PWGT1SPI: 5500 mV 
spi_imx 1000e000.cspi: probed
CAN device driver interface
sja1000 CAN netdevice driver
libphy: fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-mxc: Freescale On-Chip EHCI Host driver
usbcore: registered new interface driver usb-storage
platform 10024000.usb: Driver imx_usb requests probe deferral
mc13783-pwrbutton mc13783-pwrbutton: missing platform data
mc13xxx-rtc mc13783-rtc: rtc core: registered mc13783-rtc as rtc0
rtc-pcf8563 1-0051: chip found, driver version 0.4.3
rtc-pcf8563 1-0051: low voltage detected, date/time is not reliable.
rtc-pcf8563 1-0051: retrieved date/time is not valid.
rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc1
i2c /dev entries driver
coda 10023000.coda: Initialized CodaDx6.
coda 10023000.coda: Firmware version: 2.2.5
Driver for 1-wire Dallas network protocol.
coda 10023000.coda: codec registered as /dev/video0
lm75 1-004a: hwmon0: sensor 'lm75'
imx2-wdt 10002000.wdog: IMX2+ Watchdog Timer enabled. timeout=60s (nowayout=0)
i.MX/MPC512x SDHC driver
mxc-mmc 10014000.sdhci: Got CD GPIO #93.
mxc-mmc 10014000.sdhci: Got WP GPIO #92.
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sahara 10025000.sahara: SAHARA version 3 initialized
mmc0: new SD card at address 0002
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
mmcblk0: mmc0:0002 00000 974 MiB 
 mmcblk0: p1
TCP: cubic registered
NET: Registered protocol family 17
can: controller area network core (rev 20120528 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)
can: netlink gateway (rev 20130117) max_hops=1
5V0: disabling
3V3: disabling
w1_master_driver w1_bus_master1: w1_search: max_slave_count 64 reached, will continue next search.
ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.15.0-rc1-next-20140415-dirty ehci_hcd
usb usb1: SerialNumber: ci_hdrc.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mc13xxx-rtc mc13783-rtc: setting system clock to 1970-01-01 01:24:48 UTC (5088)
ALSA device list:
  No soundcards found.
VFS: Mounted root (cramfs filesystem) readonly on device 31:3.
devtmpfs: mounted
Freeing unused kernel memory: 168K (c05be000 - c05e8000)

starting pid 656, tty '': '/etc/rc.sysinit'

usb 1-1: new high-speed USB device number 2 using ci_hdrc
usb 1-1: New USB device found, idVendor=07d1, idProduct=3a09
usb 1-1: New USB device strings: Mfr=16, Product=32, SerialNumber=48
usb 1-1: Product: 11n adapter
usb 1-1: Manufacturer: ATHER
usb 1-1: SerialNumber: 12345

Please press Enter to activate this console.

# cat /proc/iomem 
10001000-10001fff : /soc/aipi at 10000000/dma at 10001000
10002000-10002fff : /soc/aipi at 10000000/wdog at 10002000
10006000-10006fff : /soc/aipi at 10000000/pwm at 10006000
10009000-10009fff : /soc/aipi at 10000000/owire at 10009000
1000a000-1000afff : /soc/aipi at 10000000/serial at 1000a000
1000b000-1000bfff : /soc/aipi at 10000000/serial at 1000b000
1000e000-1000efff : /soc/aipi at 10000000/cspi at 1000e000
10012000-10012fff : /soc/aipi at 10000000/i2c at 10012000
10014000-10014fff : 10014000.sdhci
10015000-100150ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015000
10015100-100151ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015100
10015200-100152ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015200
10015300-100153ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015300
10015400-100154ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015400
10015500-100155ff : /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015500
10016000-10016fff : /soc/aipi at 10000000/audmux at 10016000
1001d000-1001dfff : /soc/aipi at 10000000/i2c at 1001d000
10021000-10021fff : imx-fb
10023000-100231ff : /soc/aipi at 10020000/coda at 10023000
10024000-100241ff : /soc/aipi at 10020000/usb at 10024000
  10024000-100241ff : /soc/aipi at 10020000/usb at 10024000
10024600-100247ff : /soc/aipi at 10020000/usbmisc at 10024600
10025000-10025fff : /soc/aipi at 10020000/sahara at 10025000
1002b000-1002efff : /soc/aipi at 10020000/ethernet at 1002b000
a0000000-a7ffffff : System RAM
  a0008000-a05bd8bf : Kernel code
  a05ea000-a064e103 : Kernel data
c0000000-c1ffffff : c0000000.nor
c8000000-c87fffff : c8000000.sram
d8000000-d8000fff : /soc/nand at d8000000
d8002000-d8002fff : /soc/weim at d8002000
ffff4c00-ffffffff : /soc/iram at ffff4c00

# cat /proc/interrupts 
           CPU0       
 17:         20  mxc-avic   1  1001d000.i2c
 26:         29  mxc-avic  10  mxc-mmc
 28:          0  mxc-avic  12  10012000.i2c
 32:       6385  mxc-avic  16  1000e000.cspi
 36:         89  mxc-avic  20  1000a000.serial
 42:       3975  mxc-avic  26  i.MX Timer Tick
 45:         15  mxc-avic  29  mxc_nand
 48:          1  mxc-avic  32  DMA
 49:          0  mxc-avic  33  DMA
 50:          0  mxc-avic  34  DMA
 51:          0  mxc-avic  35  DMA
 52:          0  mxc-avic  36  DMA
 53:          0  mxc-avic  37  DMA
 54:          0  mxc-avic  38  DMA
 55:          0  mxc-avic  39  DMA
 56:          0  mxc-avic  40  DMA
 57:          0  mxc-avic  41  DMA
 58:          0  mxc-avic  42  DMA
 59:          0  mxc-avic  43  DMA
 60:          0  mxc-avic  44  DMA
 61:          0  mxc-avic  45  DMA
 62:          0  mxc-avic  46  DMA
 63:          0  mxc-avic  47  DMA
 66:         64  mxc-avic  50  1002b000.ethernet
 69:          0  mxc-avic  53  coda
 72:         21  mxc-avic  56  10024000.usb
 75:          0  mxc-avic  59  10025000.sahara
135:        654  gpio-mxc  23  mc13xxx
173:          0  gpio-mxc  29  10014000.sdhci cd
Err:          0

---
