From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Mar 2018 00:43:33 +0800
Subject: [PATCH 1/2] arm64: dts: Add msm8998 SoC and MTP board support
In-Reply-To: <20180327160154.1938-1-bjorn.andersson@linaro.org>
References: <20180327160154.1938-1-bjorn.andersson@linaro.org>
Message-ID: <201803282323.uCk1EigM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joonwoo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Andersson/arm64-dts-Add-msm8998-SoC-and-MTP-board-support/20180328-201811
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi:4:0,
                    from arch/arm64/boot/dts/qcom/msm8998-mtp.dts:6:
>> arch/arm64/boot/dts/qcom/msm8998.dtsi:5:10: fatal error: dt-bindings/clock/qcom,gcc-msm8998.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +5 arch/arm64/boot/dts/qcom/msm8998.dtsi

     3	
     4	#include <dt-bindings/interrupt-controller/arm-gic.h>
   > 5	#include <dt-bindings/clock/qcom,gcc-msm8998.h>
     6	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37868 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180329/5e955ae1/attachment-0001.gz>
