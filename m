From: lkp@intel.com (kbuild test robot)
Date: Mon, 28 Mar 2016 16:13:48 +0800
Subject: [PATCH] arm: dts: mt2701: Add clock controller device nodes
In-Reply-To: <1459142955-33209-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <201603281638.VIBfNFp6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.6-rc1 next-20160327]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/James-Liao/arm-dts-mt2701-Add-clock-controller-device-nodes/20160328-133113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/mt2701-evb.dts:16:0:
>> arch/arm/boot/dts/mt2701.dtsi:15:42: fatal error: dt-bindings/clock/mt2701-clk.h: No such file or directory
    #include <dt-bindings/clock/mt2701-clk.h>
                                             ^
   compilation terminated.

vim +15 arch/arm/boot/dts/mt2701.dtsi

     9	 * This program is distributed in the hope that it will be useful,
    10	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
    11	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    12	 * GNU General Public License for more details.
    13	 */
    14	
  > 15	#include <dt-bindings/clock/mt2701-clk.h>
    16	#include <dt-bindings/interrupt-controller/irq.h>
    17	#include <dt-bindings/interrupt-controller/arm-gic.h>
    18	#include "skeleton64.dtsi"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160328/3c6b7a0e/attachment-0001.obj>
