From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 07 Jan 2013 18:41:10 +0800
Subject: [stericsson:realview 1/1]
 arch/arm/plat-versatile/fpga-id.c:13:27: fatal error: mach/hardware.h: No
 such file or directory
Message-ID: <50eaa646.pjHp1lCLCL33Xa6c%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git realview
head:   ceba20ea50c6138f0b71075b97b1de82cdb42ca4
commit: ceba20ea50c6138f0b71075b97b1de82cdb42ca4 [1/1] ARM: print FPGA info on plat-versatile variants
config: make ARCH=arm imx_v6_v7_defconfig

All error/warnings:

arch/arm/plat-versatile/fpga-id.c:13:27: fatal error: mach/hardware.h: No such file or directory
compilation terminated.

vim +13 arch/arm/plat-versatile/fpga-id.c

ceba20ea Linus Walleij 2011-01-27   7   * Author: Linus Walleij <linus.walleij@stericsson.com>
ceba20ea Linus Walleij 2011-01-27   8   */
ceba20ea Linus Walleij 2011-01-27   9  #include <linux/kernel.h>
ceba20ea Linus Walleij 2011-01-27  10  #include <linux/init.h>
ceba20ea Linus Walleij 2011-01-27  11  #include <linux/io.h>
ceba20ea Linus Walleij 2011-01-27  12  #include <asm/mach-types.h>
ceba20ea Linus Walleij 2011-01-27 @13  #include <mach/hardware.h>
ceba20ea Linus Walleij 2011-01-27  14  #include <mach/platform.h>
ceba20ea Linus Walleij 2011-01-27  15  
ceba20ea Linus Walleij 2011-01-27  16  struct versatile_fpga_id {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
