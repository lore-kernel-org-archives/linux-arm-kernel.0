From: lkp@intel.com (kbuild test robot)
Date: Wed, 13 Jun 2018 17:33:53 +0800
Subject: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20180613161314.14894-3-yixun.lan@amlogic.com>
References: <20180613161314.14894-3-yixun.lan@amlogic.com>
Message-ID: <201806131738.lVPaDHhQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/mtd-rawnand-meson-add-Amlogic-NAND-driver-support/20180613-161917
base:   git://git.infradead.org/linux-mtd.git nand/next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/mtd/nand/raw/meson_nand.c:21:10: fatal error: clk-regmap.h: No such file or directory
    #include "clk-regmap.h"
             ^~~~~~~~~~~~~~
   compilation terminated.

vim +21 drivers/mtd/nand/raw/meson_nand.c

  > 21	#include "clk-regmap.h"
    22	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62787 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/043f3907/attachment-0001.gz>
