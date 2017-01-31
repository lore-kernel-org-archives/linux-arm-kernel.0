From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 06:22:07 +0800
Subject: [stericsson:mmc-no-NULL 16/20] drivers/mmc/core/block.c:1607:2-3:
 Unneeded semicolon
Message-ID: <201702010604.Y8H0jjQk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   cbda9cc03b53855a310c144100f860d7e0876af4
commit: 7e2fe71f6be6605cf7c132273eda758562e1c1c4 [16/20] mmc: block: respect bool returned from blk_end_request()


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/core/block.c:1607:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
