From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Jul 2018 23:33:17 +0800
Subject: [arm-soc:qcom/arm64 5/10]
 arch/arm64/boot/dts/qcom/sdm845.dtsi:10:10: fatal error:
 dt-bindings/soc/qcom,rpmh-rsc.h: No such file or directory
Message-ID: <201807262312.blW4meoN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
head:   e53db018315b7660bb7000a29e79faff2496c2c2
commit: c83545d95376c2249c7990ce2dd76f387ce68bef [5/10] arm64: dts: sdm845: Add rpmh-rsc node
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c83545d95376c2249c7990ce2dd76f387ce68bef
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sdm845-mtp.dts:10:0:
>> arch/arm64/boot/dts/qcom/sdm845.dtsi:10:10: fatal error: dt-bindings/soc/qcom,rpmh-rsc.h: No such file or directory
    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +10 arch/arm64/boot/dts/qcom/sdm845.dtsi

  > 10	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    11	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38873 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/1c8dda88/attachment-0001.gz>
