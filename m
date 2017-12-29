From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Dec 2017 17:32:18 +0800
Subject: [PATCH] ARM: imx: introduce imx_l2c310_write_sec
In-Reply-To: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
References: <1514453750-15479-1-git-send-email-peng.fan@nxp.com>
Message-ID: <201712291710.oGgg0Sre%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peng-Fan/ARM-imx-introduce-imx_l2c310_write_sec/20171229-150558
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-arm5 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/system.o: In function `imx_l2c310_write_sec':
>> system.c:(.text+0x44): undefined reference to `__arm_smccc_smc'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29005 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/a4287339/attachment-0001.gz>
