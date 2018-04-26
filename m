From: lkp@intel.com (kbuild test robot)
Date: Fri, 27 Apr 2018 02:25:23 +0800
Subject: [PATCH v7 01/11] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180420211022.11759-2-mylene.josserand@bootlin.com>
References: <20180420211022.11759-2-mylene.josserand@bootlin.com>
Message-ID: <201804270202.0Krw6Gih%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180423-051823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   /tmp/ccQKy2ZB.s: Assembler messages:
>> /tmp/ccQKy2ZB.s:73: Error: selected processor does not support `isb' in ARM mode
>> /tmp/ccQKy2ZB.s:74: Error: selected processor does not support `dsb' in ARM mode

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65017 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180427/a13e87ab/attachment-0001.gz>
