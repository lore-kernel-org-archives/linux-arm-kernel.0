From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 16 Feb 2017 00:53:14 +0800
Subject: [xlnx:master 289/322] drivers/bluetooth/btwilink.c:350:3-8: No need
 to set .owner here. The core will do it.
Message-ID: <201702160012.bLzbbwbG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   3b135b44d6c189c52994efe4ca1502cca8382633
commit: 71678890658e79322d066fd6cd4fdef5ed6a8884 [289/322] btwilink: add minimal device tree support


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btwilink.c:350:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
