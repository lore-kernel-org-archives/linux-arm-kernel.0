From: lkp@intel.com (kbuild test robot)
Date: Fri, 30 Jun 2017 21:06:09 +0800
Subject: [PATCH v7 3/4] arm64: dts: Add ipq8074 SoC and HK01 board support
In-Reply-To: <1498717114-338-4-git-send-email-varada@codeaurora.org>
Message-ID: <201706302147.VMSgPQav%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varadarajan,

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on v4.12-rc7]
[cannot apply to robh/for-next next-20170630]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Varadarajan-Narayanan/Add-minimal-boot-support-for-IPQ8074/20170630-161146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/ipq8074-hk01.dts:13:0:
>> arch/arm64/boot/dts/qcom/ipq8074.dtsi:15:48: fatal error: dt-bindings/clock/qcom,gcc-ipq8074.h: No such file or directory
    #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
                                                   ^
   compilation terminated.

vim +15 arch/arm64/boot/dts/qcom/ipq8074.dtsi

     9	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
    10	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    11	 * GNU General Public License for more details.
    12	 */
    13	
    14	#include <dt-bindings/interrupt-controller/arm-gic.h>
  > 15	#include <dt-bindings/clock/qcom,gcc-ipq8074.h>
    16	
    17	/ {
    18		model = "Qualcomm Technologies, Inc. IPQ8074";

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/dd28e507/attachment-0001.gz>
