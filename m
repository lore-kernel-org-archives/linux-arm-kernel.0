From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Jun 2018 11:04:48 +0800
Subject: [PATCH 2/3] ARM: imx: add cpu idle support for i.MX6SLL
In-Reply-To: <1527664358-17844-2-git-send-email-Anson.Huang@nxp.com>
References: <1527664358-17844-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <201806021025.PRhFlcyX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.17-rc7 next-20180601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anson-Huang/ARM-imx-add-L2-page-power-control-for-GPC/20180602-080503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
>> mach-imx6sl.c:(.init.text+0x2c): undefined reference to `imx6sx_cpuidle_init'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31074 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180602/b9cf1083/attachment-0001.gz>
