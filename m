From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Nov 2015 13:06:57 +0800
Subject: [PATCH 2/4] arm64: dts: Add msm8996 SoC and MTP board support
In-Reply-To: <1447809149-29724-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <201511181303.U0nlsppa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.4-rc1 next-20151117]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/devicetree-bindings-Document-Kryo-cpu/20151118-091558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi:14:0,
                    from arch/arm64/boot/dts/qcom/msm8996-mtp.dts:16:
>> arch/arm64/boot/dts/qcom/msm8996.dtsi:14:48: fatal error: dt-bindings/clock/qcom,gcc-msm8996.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
                                                   ^
   compilation terminated.

vim +14 arch/arm64/boot/dts/qcom/msm8996.dtsi

     8	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
     9	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    10	 * GNU General Public License for more details.
    11	 */
    12	
    13	#include <dt-bindings/interrupt-controller/arm-gic.h>
  > 14	#include <dt-bindings/clock/qcom,gcc-msm8996.h>
    15	#include <dt-bindings/clock/qcom,mmcc-msm8996.h>
    16	
    17	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45533 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151118/49315e76/attachment-0001.obj>
