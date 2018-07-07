From: lkp@intel.com (kbuild test robot)
Date: Sun, 8 Jul 2018 00:52:41 +0800
Subject: [PATCH] ARM: imx: fix i.MX6SLL build
In-Reply-To: <20180706125523.3480661-1-arnd@arndb.de>
References: <20180706125523.3480661-1-arnd@arndb.de>
Message-ID: <201807080053.KhEzoodh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I love your patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on next-20180706]
[cannot apply to v4.18-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/ARM-imx-fix-i-MX6SLL-build/20180707-012834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

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
Size: 31187 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180708/9dff84aa/attachment-0001.gz>
