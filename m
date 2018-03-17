From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Mar 2018 14:13:55 +0800
Subject: [PATCH] ARM: dts: stm32: Enable stm32mp1 clock driver on
 stm32mp157c
In-Reply-To: <1521098327-13958-1-git-send-email-gabriel.fernandez@st.com>
References: <1521098327-13958-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <201803171420.CjlcN0Pg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180309]
[cannot apply to v4.16-rc4 v4.16-rc3 v4.16-rc2 v4.16-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/gabriel-fernandez-st-com/ARM-dts-stm32-Enable-stm32mp1-clock-driver-on-stm32mp157c/20180317-102206
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/stm32mp157c-ed1.dts:8:0:
>> arch/arm/boot/dts/stm32mp157c.dtsi:7:10: fatal error: dt-bindings/clock/stm32mp1-clks.h: No such file or directory
    #include <dt-bindings/clock/stm32mp1-clks.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +7 arch/arm/boot/dts/stm32mp157c.dtsi

   > 7	#include <dt-bindings/clock/stm32mp1-clks.h>
     8	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/44ebd997/attachment-0001.gz>
