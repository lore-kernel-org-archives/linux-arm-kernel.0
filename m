From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Aug 2018 15:06:44 +0800
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB
 regulators
In-Reply-To: <20180810215150.82490-3-dianders@chromium.org>
References: <20180810215150.82490-3-dianders@chromium.org>
Message-ID: <201808121444.cbLObD3h%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Douglas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on agross/for-next]
[cannot apply to v4.18-rc8 next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/arm64-dts-sdm845-Add-RPMh-regulators-and-usb/20180811-164836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/qcom/sdm845-mtp.dts:10:10: fatal error: dt-bindings/regulator/qcom,rpmh-regulator.h: No such file or directory
    #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +10 arch/arm64/boot/dts/qcom/sdm845-mtp.dts

     9	
  > 10	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
    11	#include "sdm845.dtsi"
    12	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38888 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180812/c4fd4724/attachment-0001.gz>
