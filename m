From: lkp@intel.com (kbuild test robot)
Date: Tue, 29 May 2018 20:06:12 +0800
Subject: [patch v22 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1527508827-30724-2-git-send-email-oleksandrs@mellanox.com>
References: <1527508827-30724-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201805291924.tuUwoWI9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20180529-185749
config: i386-tinyconfig (attached as .config)
compiler: gcc-8 (Debian 8.1.0-3) 8.1.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> ./usr/include/linux/jtag.h:63: found __[us]{8,16,32,64} type without #include <linux/types.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6306 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/06e7f9c3/attachment.gz>
