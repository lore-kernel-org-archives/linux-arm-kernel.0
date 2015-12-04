From: lkp@intel.com (kbuild test robot)
Date: Sat, 5 Dec 2015 02:14:48 +0800
Subject: [PATCH 2/3] Add support for monitoring gpio switches
In-Reply-To: <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <201512050224.lVULPyNu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martyn,

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.4-rc3 next-20151203]

url:    https://github.com/0day-ci/linux/commits/Martyn-Welch/Device-tree-binding-documentation-for-gpio-switch/20151205-014105


coccinelle warnings: (new ones prefixed by >>)

>> drivers/misc/gpio-switch.c:98:34-40: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
