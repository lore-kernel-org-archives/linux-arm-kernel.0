From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Mar 2018 04:35:02 +0800
Subject: [PATCH v6 11/11] clk: actions: Add S900 SoC clock support
In-Reply-To: <20180324133159.4824-12-manivannan.sadhasivam@linaro.org>
References: <20180324133159.4824-12-manivannan.sadhasivam@linaro.org>
Message-ID: <201803260403.yVM0I8Zk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc6]
[cannot apply to clk/clk-next next-20180323]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-clock-driver-for-Actions-S900-SoC/20180325-231339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/clk/actions/owl-s900.c:23:10: fatal error: dt-bindings/clock/actions,s900-cmu.h: No such file or directory
    #include <dt-bindings/clock/actions,s900-cmu.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +23 drivers/clk/actions/owl-s900.c

    22	
  > 23	#include <dt-bindings/clock/actions,s900-cmu.h>
    24	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63116 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/0df88011/attachment-0001.gz>
