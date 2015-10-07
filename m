From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 01:56:36 +0800
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add thermal zone node for
 mt8173.
In-Reply-To: <1444220561-26139-3-git-send-email-dawei.chien@mediatek.com>
Message-ID: <201510080149.92CvJ0jV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dawei.Chien,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/mediatek/mt8173-evb.dts:16:0:
>> arch/arm64/boot/dts/mediatek/mt8173.dtsi:19:40: fatal error: dt-bindings/thermal/mt8173.h: No such file or directory
    #include <dt-bindings/thermal/mt8173.h>
                                           ^
   compilation terminated.

vim +19 arch/arm64/boot/dts/mediatek/mt8173.dtsi

    13	
    14	#include <dt-bindings/clock/mt8173-clk.h>
    15	#include <dt-bindings/interrupt-controller/irq.h>
    16	#include <dt-bindings/interrupt-controller/arm-gic.h>
    17	#include <dt-bindings/power/mt8173-power.h>
    18	#include <dt-bindings/reset-controller/mt8173-resets.h>
  > 19	#include <dt-bindings/thermal/mt8173.h>
    20	#include "mt8173-pinfunc.h"
    21	
    22	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45525 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/27c75c7a/attachment-0001.obj>
