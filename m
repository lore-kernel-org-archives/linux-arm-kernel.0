From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 Aug 2017 13:22:55 +0800
Subject: [patch v2 1/2] drivers: jtag: Add JTAG core driver
In-Reply-To: <1502115467-1735-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201708091323.G1dgtioU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc4 next-20170808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/drivers-jtag-Add-JTAG-core-driver/20170809-100030
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from include/linux/jtag.h:14:0,
                    from drivers/jtag/jtag.c:13:
>> include/uapi/linux/jtag.h:14:19: fatal error: types.h: No such file or directory
    #include <types.h>
                      ^
   compilation terminated.

vim +14 include/uapi/linux/jtag.h

    13	
  > 14	#include <types.h>
    15	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61093 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170809/2124f154/attachment-0001.gz>
