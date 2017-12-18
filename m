From: lkp@intel.com (kbuild test robot)
Date: Mon, 18 Dec 2017 13:31:54 +0800
Subject: [PATCH v8] arm64: dts: meson-axg: switch uart_ao clock to CLK81
In-Reply-To: <20171215141741.175985-1-yixun.lan@amlogic.com>
References: <20171215141741.175985-1-yixun.lan@amlogic.com>
Message-ID: <201712181217.MyHBkHay%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15-rc4 next-20171215]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/arm64-dts-meson-axg-switch-uart_ao-clock-to-CLK81/20171218-100949
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
>> arch/arm64/boot/dts/amlogic/meson-axg.dtsi:10:10: fatal error: dt-bindings/clock/axg-clkc.h: No such file or directory
    #include <dt-bindings/clock/axg-clkc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +10 arch/arm64/boot/dts/amlogic/meson-axg.dtsi

  > 10	#include <dt-bindings/clock/axg-clkc.h>
    11	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/2b7bfe2a/attachment-0001.gz>
