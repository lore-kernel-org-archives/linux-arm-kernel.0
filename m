From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Apr 2018 19:13:59 +0800
Subject: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
In-Reply-To: <20180403061836.3926-9-mylene.josserand@bootlin.com>
References: <20180403061836.3926-9-mylene.josserand@bootlin.com>
Message-ID: <201804031907.1T91Hxm0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on next-20180403]
[cannot apply to v4.16]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180403-143751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-sunxi/sunxi.o: In function `sun8i_cntvoff_init':
>> sunxi.c:(.init.text+0x3c): undefined reference to `smp_init_cntvoff'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31765 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/6e396f4b/attachment-0001.gz>
