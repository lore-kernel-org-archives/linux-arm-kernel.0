From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Mar 2018 03:19:18 +0800
Subject: [PATCH v6 01/11] arm64: dts: actions: Add S900 clock management
 unit nodes
In-Reply-To: <20180324133159.4824-2-manivannan.sadhasivam@linaro.org>
References: <20180324133159.4824-2-manivannan.sadhasivam@linaro.org>
Message-ID: <201803260317.znSnSBIU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc6]
[cannot apply to clk/clk-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-clock-driver-for-Actions-S900-SoC/20180325-231339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/actions/s900-bubblegum-96.dts:9:0:
>> arch/arm64/boot/dts/actions/s900.dtsi:7:10: fatal error: dt-bindings/clock/actions,s900-cmu.h: No such file or directory
    #include <dt-bindings/clock/actions,s900-cmu.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +7 arch/arm64/boot/dts/actions/s900.dtsi

   > 7	#include <dt-bindings/clock/actions,s900-cmu.h>
     8	#include <dt-bindings/interrupt-controller/arm-gic.h>
     9	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37852 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/569ab3b4/attachment-0001.gz>
