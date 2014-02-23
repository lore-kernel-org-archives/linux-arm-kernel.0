From: juergen@kreuzholzen.de (Juergen Beisert)
Date: Sun, 23 Feb 2014 12:02:06 +0100
Subject: Linux-3.13.5/Samsung S3C6410/Mini6410: What does this warning mean?
Message-ID: <201402231202.06468.juergen@kreuzholzen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

trying to get a current 3.13.5 to run on my Mini6410.

I still boot the platform (not the device tree) variant.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:883 __clk_enable+0x24/0x9c()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.5-ptx-master #9
[<c00131e0>] (unwind_backtrace+0x0/0xe0) from [<c0010b44>] (show_stack+0x10/0x14)
[<c0010b44>] (show_stack+0x10/0x14) from [<c001c380>] (warn_slowpath_common+0x60/0x80)
[<c001c380>] (warn_slowpath_common+0x60/0x80) from [<c001c430>] (warn_slowpath_null+0x18/0x20)
[<c001c430>] (warn_slowpath_null+0x18/0x20) from [<c01fdbe8>] (__clk_enable+0x24/0x9c)
[<c01fdbe8>] (__clk_enable+0x24/0x9c) from [<c01fdda8>] (clk_enable+0x18/0x2c)
[<c01fdda8>] (clk_enable+0x18/0x2c) from [<c0018e04>] (s3c_adc_probe+0x11c/0x194)
[<c0018e04>] (s3c_adc_probe+0x11c/0x194) from [<c0190ecc>] (platform_drv_probe+0x18/0x48)
[<c0190ecc>] (platform_drv_probe+0x18/0x48) from [<c018f8e8>] (driver_probe_device+0xac/0x1e8)
[<c018f8e8>] (driver_probe_device+0xac/0x1e8) from [<c018fad0>] (__driver_attach+0x68/0x8c)
[<c018fad0>] (__driver_attach+0x68/0x8c) from [<c018e180>] (bus_for_each_dev+0x70/0x84)
[<c018e180>] (bus_for_each_dev+0x70/0x84) from [<c018f150>] (bus_add_driver+0xd8/0x1cc)
[<c018f150>] (bus_add_driver+0xd8/0x1cc) from [<c01900f8>] (driver_register+0x9c/0xe0)
[<c01900f8>] (driver_register+0x9c/0xe0) from [<c0392210>] (adc_init+0x10/0x38)
[<c0392210>] (adc_init+0x10/0x38) from [<c0008724>] (do_one_initcall+0x94/0x134)
[<c0008724>] (do_one_initcall+0x94/0x134) from [<c038dab8>] (kernel_init_freeable+0xf4/0x1b4)
[<c038dab8>] (kernel_init_freeable+0xf4/0x1b4) from [<c028d2f0>] (kernel_init+0x8/0x100)
[<c028d2f0>] (kernel_init+0x8/0x100) from [<c000db08>] (ret_from_fork+0x14/0x2c)
---[ end trace 916830ab0740046a ]---

Any idea what is means?

Regards,
jbe
