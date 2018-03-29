From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Mar 2018 16:59:51 +0800
Subject: [PATCH v3 1/3] arm64: dts: meson-axg: add AO clock driver DT info
In-Reply-To: <20180328030130.240336-2-yixun.lan@amlogic.com>
References: <20180328030130.240336-2-yixun.lan@amlogic.com>
Message-ID: <201803291636.a7yizm7C%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Qiufang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/ARM64-dts-meson-axg-add-AO-clock-driver/20180329-134803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/amlogic/meson-axg-s400.dts:9:0:
>> arch/arm64/boot/dts/amlogic/meson-axg.dtsi:11:10: fatal error: dt-bindings/clock/axg-aoclkc.h: No such file or directory
    #include <dt-bindings/clock/axg-aoclkc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +11 arch/arm64/boot/dts/amlogic/meson-axg.dtsi

  > 11	#include <dt-bindings/clock/axg-aoclkc.h>
    12	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37934 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180329/321d2e53/attachment-0001.gz>
