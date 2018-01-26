From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Jan 2018 04:00:13 +0800
Subject: [PATCH BUGFIX] ARM: dts: imx6ull: fix the imx6ull-14x14-evk
 configuration
In-Reply-To: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <201801270340.rd9I0PM7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on next-20180126]
[cannot apply to v4.15-rc9]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lothar-Wa-mann/ARM-dts-imx6ull-fix-the-imx6ull-14x14-evk-configuration/20180127-010850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-at91_dt_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/boot/dts/imx6ul-14x14-evk.dts:12:10: fatal error: imx6ul-14x14-evk.dtsi: No such file or directory
    #include "imx6ul-14x14-evk.dtsi"
             ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> arch/arm/boot/dts/imx6ull-14x14-evk.dts:45:10: fatal error: imx6ul-14x14-evk.dtsi: No such file or directory
    #include "imx6ul-14x14-evk.dtsi"
             ^~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +12 arch/arm/boot/dts/imx6ul-14x14-evk.dts

    10	
    11	#include "imx6ul.dtsi"
  > 12	#include "imx6ul-14x14-evk.dtsi"
    13	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180127/39903619/attachment-0001.gz>
