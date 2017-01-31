From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 07:42:02 +0800
Subject: [stericsson:ux500-devicetree 4/4]
 arch/arm/boot/dts/ste-dbx5x0.dtsi:17:42: fatal error:
 dt-bindings/clock/ste-ab8500.h: No such file or directory
Message-ID: <201702010700.bgYKdYbS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-devicetree
head:   312ae21fdd56b54bafc0817ab3a0a8aa85b5b8cc
commit: 312ae21fdd56b54bafc0817ab3a0a8aa85b5b8cc [4/4] ARM: dts: add the AB8500 clocks to the device tree
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 312ae21fdd56b54bafc0817ab3a0a8aa85b5b8cc
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/ste-hrefv60plus.dtsi:12:0,
                    from arch/arm/boot/dts/ste-hrefv60plus-tvk.dts:15:
>> arch/arm/boot/dts/ste-dbx5x0.dtsi:17:42: fatal error: dt-bindings/clock/ste-ab8500.h: No such file or directory
    #include <dt-bindings/clock/ste-ab8500.h>
                                             ^
   compilation terminated.

vim +17 arch/arm/boot/dts/ste-dbx5x0.dtsi

    11	
    12	#include <dt-bindings/interrupt-controller/irq.h>
    13	#include <dt-bindings/interrupt-controller/arm-gic.h>
    14	#include <dt-bindings/mfd/dbx500-prcmu.h>
    15	#include <dt-bindings/arm/ux500_pm_domains.h>
    16	#include <dt-bindings/gpio/gpio.h>
  > 17	#include <dt-bindings/clock/ste-ab8500.h>
    18	#include "skeleton.dtsi"
    19	
    20	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22125 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/d38feee8/attachment-0001.gz>
