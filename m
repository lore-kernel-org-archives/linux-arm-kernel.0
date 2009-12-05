From: subbu31mani@gmail.com (Subramani Venkatesh)
Date: Sat, 5 Dec 2009 10:15:02 -0500
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
References: <OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
Message-ID: <25dd9bf10912050715y74fb2e51w99983efac6da3f2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vadivelan,
Why don't you send us inittab file too, that would help us to debug the
problem.
It looks like a baudrate issues...

Regards,
Subbu
On Wed, Nov 4, 2009 at 2:39 AM, Vadivelan M <vadivelan.m@tcs.com> wrote:

>
> Hi,
> I am porting Linux-2.6.28 Kernel on IMX27based board.
> Filesystem is mounted and after that we are getting message Freeing init
> memory and some junk characters are coming. Keyboards are responding.
> Can anybody help us in this regard.
>
> Thanks,
>
> Please see the following logs ..
>
> Launch LinuxUncompressing
> Linux......................................................................
> done, booting the kernel.
> Linux version 2.6.28-arm2 (root at localhost.localdomain) (gcc version 4.1.1)
> #75 Wed Oct 28 13:12:53 IST 2009
> CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Freescale i.MX27ADS
> Memory policy: ECC disabled, Data cache writeback
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> Kernel command line: root=/dev/ram rw mem=64M console=ttymxc0,115200
> MXC GPIO hardware
> MXC IRQ initialized
> PID hash table entries: 256 (order: 8, 1024 bytes)
>
>  Clock input source is 26000000
>
>  After for loop
>  test1
>  CCM_PCCR1 = fe5aef88
>  b4 spll_clk.disableConsole: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 64MB = 64MB total
> Memory: 60780KB available (1956K code, 252K data, 92K init)
> Calibrating delay loop... 132.71 BogoMIPS (lpj=663552)
> Security Framework initialized
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> kernel thread started : M.V<5>SCSI subsystem initialized
> checking if image is initramfs...it isn't (no cpio magic); looks like an
> initrd
> do_sys_open entry<6>Freeing initrd memory: 1792K
> NetWinder Floating Point Emulator V0.97 (extended precision)
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFS: nTxBlock = 489, nTxLock = 3914
> msgmni has been set to 122
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: IMX driver
> imx-uart.0: ttymxc0 at MMIO 0x1000a000 (irq = 20) is a IMX
> console [ttymxc0] enabled
> imx-uart.1: ttymxc1 at MMIO 0x1000b000 (irq = 19) is a IMX
> imx-uart.2: ttymxc2 at MMIO 0x1000c000 (irq = 18) is a IMX
> imx-uart.3: ttymxc3 at MMIO 0x1000d000 (irq = 17) is a IMX
> imx-uart.4: ttymxc4 at MMIO 0x1001b000 (irq = 49) is a IMX
> imx-uart.5: ttymxc5 at MMIO 0x1001c000 (irq = 48) is a IMX
> brd: module loaded
> loop: module loaded
> st: Version 20080504, fixed bufsize 32768, s/g segs 256
> Driver 'st' needs updating - please use bus_type methods
> Driver 'sd' needs updating - please use bus_type methods
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> do_sys_open entrydo_sys_open entry<5>RAMDISK: Compressed image found at
> block 0
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> VFS: Mounted root (ext2 filesystem).
> Freeing init memory: 92K
>
>
> After this some junk characters are coming like ....
>
> ????&#531488;0^???r?'??????r:???????:??M? ??D?d?z ???
> ???8V?`?????V?]nn]^??m8m??^? ?m? E??N??8??6???:]???
>
>
> Thanks and Regards,
>
> Vadivelan M
>
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
>
>
>
>
> _______________________________________________
> linux-arm mailing list
> linux-arm at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091205/7dea7d61/attachment-0001.htm>
