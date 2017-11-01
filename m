From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Nov 2017 05:34:04 +0800
Subject: [patch v10 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1509365528-28803-2-git-send-email-oleksandrs@mellanox.com>
References: <1509365528-28803-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201711020548.ETMSMVaX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.14-rc7]
[cannot apply to next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20171102-045624
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> ./usr/include/linux/jtag.h:74: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6687 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/d7267249/attachment-0001.gz>
