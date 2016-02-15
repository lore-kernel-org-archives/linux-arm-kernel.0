From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 Feb 2016 17:34:20 +0800
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201602151750.ChNRB1qR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.5-rc4 next-20160215]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/dma-mv_xor_v2-new-driver/20160215-160120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/dma/mv_xor_v2.c:870:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
