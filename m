From: lkp@intel.com (kbuild test robot)
Date: Tue, 29 Mar 2016 14:03:37 +0800
Subject: [PATCH v2 5/9] ARM: dts: qcom: msm8974: Introduce the wcnss
 remoteproc node
In-Reply-To: <1459222625-11440-6-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <201603291305.IgQ6FAlE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

[auto build test ERROR on v4.6-rc1]
[also build test ERROR on next-20160329]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Andersson/Qualcomm-WCNSS-remoteproc/20160329-114231
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/qcom-apq8074-dragonboard.dts:1:0:
>> arch/arm/boot/dts/qcom-msm8974.dtsi:5:42: fatal error: dt-bindings/clock/qcom,rpmcc.h: No such file or directory
    #include <dt-bindings/clock/qcom,rpmcc.h>
                                             ^
   compilation terminated.

vim +5 arch/arm/boot/dts/qcom-msm8974.dtsi

     1	/dts-v1/;
     2	
     3	#include <dt-bindings/interrupt-controller/arm-gic.h>
     4	#include <dt-bindings/clock/qcom,gcc-msm8974.h>
   > 5	#include <dt-bindings/clock/qcom,rpmcc.h>
     6	#include "skeleton.dtsi"
     7	
     8	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/d4b63b23/attachment-0001.obj>
