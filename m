From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 18 Nov 2016 19:30:07 +0800
Subject: [arm-soc:qcom/arm64 11/13]
 arch/arm64/boot/dts/qcom/msm8992.dtsi:14:48: fatal error:
 dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
Message-ID: <201611181905.d4hFQa7z%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
head:   feeaf56ac78d283efe65ea60ec999d4bf3cf395e
commit: 6a6d1978f9c0d818b4370903e1f3eecf1681c932 [11/13] arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X) support
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6a6d1978f9c0d818b4370903e1f3eecf1681c932
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts:16:0:
>> arch/arm64/boot/dts/qcom/msm8992.dtsi:14:48: fatal error: dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-msm8994.h>
                                                   ^
   compilation terminated.

vim +14 arch/arm64/boot/dts/qcom/msm8992.dtsi

     8	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
     9	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    10	 * GNU General Public License for more details.
    11	 */
    12	
    13	#include <dt-bindings/interrupt-controller/arm-gic.h>
  > 14	#include <dt-bindings/clock/qcom,gcc-msm8994.h>
    15	
    16	/ {
    17		model = "Qualcomm Technologies, Inc. MSM 8992";

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31923 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161118/3411caec/attachment-0001.gz>
