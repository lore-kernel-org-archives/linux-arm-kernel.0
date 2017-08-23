From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Aug 2017 18:02:31 +0800
Subject: [patch v5 1/3] drivers: jtag: Add JTAG core driver
In-Reply-To: <1503315069-29465-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201708231747.SIlkHSak%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc6 next-20170823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20170824-004528
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

>> ./usr/include/linux/jtag.h:14: include of <linux/types.h> is preferred over <asm/types.h>
   ./usr/include/linux/jtag.h:76: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6016 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/d1fb014b/attachment.gz>
