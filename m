From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Mar 2018 00:40:40 +0800
Subject: [PATCH 2/2] drivers: soc: xilinx: Add ZynqMP power domain driver
In-Reply-To: <1519775750-21297-3-git-send-email-jollys@xilinx.com>
References: <1519775750-21297-3-git-send-email-jollys@xilinx.com>
Message-ID: <201803030009.FUisiLBP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jolly,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.16-rc3 next-20180302]
[cannot apply to xlnx/master mediatek/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jolly-Shah/drivers-soc-xilinx-Add-support-for-ZynqMP-power-domain-driver/20180302-213151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/soc/xilinx/zynqmp/pm_domains.c:19:10: fatal error: linux/firmware/xilinx/zynqmp/firmware.h: No such file or directory
    #include <linux/firmware/xilinx/zynqmp/firmware.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +19 drivers/soc/xilinx/zynqmp/pm_domains.c

  > 19	#include <linux/firmware/xilinx/zynqmp/firmware.h>
    20	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37892 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180303/5a338094/attachment-0001.gz>
