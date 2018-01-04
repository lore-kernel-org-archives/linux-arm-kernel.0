From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 5 Jan 2018 03:46:29 +0800
Subject: [arm-soc:next/dt 26/27] arch/arm64/boot/dts/sprd/sc9860.dtsi:10:10:
 fatal error: dt-bindings/clock/sprd,sc9860-clk.h: No such file or directory
Message-ID: <201801050326.Uydt4PFu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/dt
head:   b304c1c57f372c68a7a143b3b300c1a4666c8f7d
commit: 22f37a242925d28f7055639db64ea429afb50e54 [26/27] arm64: dts: add clocks for SC9860
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 22f37a242925d28f7055639db64ea429afb50e54
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/sprd/sp9860g-1h10.dts:11:0:
>> arch/arm64/boot/dts/sprd/sc9860.dtsi:10:10: fatal error: dt-bindings/clock/sprd,sc9860-clk.h: No such file or directory
    #include <dt-bindings/clock/sprd,sc9860-clk.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +10 arch/arm64/boot/dts/sprd/sc9860.dtsi

  > 10	#include <dt-bindings/clock/sprd,sc9860-clk.h>
    11	#include "whale2.dtsi"
    12	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37439 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180105/4f8f0570/attachment-0001.gz>
