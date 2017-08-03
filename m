From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 22:35:44 +0800
Subject: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201708032250.cmVljGeY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc3 next-20170803]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20170803-110721


coccinelle warnings: (new ones prefixed by >>)

>> drivers/jtag/jtag-aspeed.c:724:37-40: ERROR: Missing resource_size with res

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
