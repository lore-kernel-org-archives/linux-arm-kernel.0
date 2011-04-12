From: Murali.p@kpitcummins.com (Murali Mohan p)
Date: Tue, 12 Apr 2011 15:52:10 +0530
Subject: Kernel hangs at Freeing Memory 88K
Message-ID: <76E258664B189C4CBEF125491CA11ECC949D9D5A4B@KCINPUNHJCMS01.kpit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,
When I try to boot the linux from ARM1176jzf-s EB board, the linux kernel hangs at Freeing init memory: 88K. Could you please suggest me the right solution for this .
Could you please find the log details below and suggest me accordingly.


Address Name
------- ----
0x40000000 SYSTEM.DAT
0x40010000 Boot_Monitor

Flash Area Base 0x40040000

Address Name
------- ----
0x40040000 u-boot_realview_eb
0x40080000 base_linux
0x40980000 uImage-2.6

Flash Area Base 0x44000000

Address Name
------- ----
0x44000000 SYSTEM.DAT

Flash Area Base 0x44040000

Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
1 cmdlinepart partitions found on MTD device armflash.0
Creating 1 MTD partitions on "armflash.0":
0x00080000-0x004ae000 : "cramfs"
mtd: partition "cramfs" doesn't end on an erase block -- force read-only
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 200
6 UTC).
aaci-pl041 fpga:04: ARM AC'97 Interface at 0x0000000010004000, irq 51, fifo 512
input: AT Raw Set 2 keyboard as /class/input/input0
atkbd.c: keyboard reset failed on fpga:07
ALSA device list:
#0: ARM AC'97 Interface at 0x0000000010004000, irq 51
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 4
VFS: Mounted root (cramfs filesystem) readonly.
Freeing init memory: 88K


Thanks & Regards,
Murali.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110412/e1234349/attachment-0001.html>
