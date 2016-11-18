From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 18 Nov 2016 20:20:07 +0800
Subject: [arm-soc:qcom/arm64 13/13]
 arch/arm64/boot/dts/qcom/msm8994.dtsi:14:48: fatal error:
 dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
Message-ID: <201611182005.RuBSvaJ7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git qcom/arm64
head:   feeaf56ac78d283efe65ea60ec999d4bf3cf395e
commit: feeaf56ac78d283efe65ea60ec999d4bf3cf395e [13/13] arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout feeaf56ac78d283efe65ea60ec999d4bf3cf395e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts:16:0:
>> arch/arm64/boot/dts/qcom/msm8994.dtsi:14:48: fatal error: dt-bindings/clock/qcom,gcc-msm8994.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-msm8994.h>
                                                   ^
   compilation terminated.

vim +14 arch/arm64/boot/dts/qcom/msm8994.dtsi

     8	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
     9	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    10	 * GNU General Public License for more details.
    11	 */
    12	
    13	#include <dt-bindings/interrupt-controller/arm-gic.h>
  > 14	#include <dt-bindings/clock/qcom,gcc-msm8994.h>
    15	
    16	/ {
    17		model = "Qualcomm Technologies, Inc. MSM 8994";

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31923 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161118/0ec2fd4b/attachment-0001.gz>
