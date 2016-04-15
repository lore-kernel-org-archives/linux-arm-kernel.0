From: lkp@intel.com (kbuild test robot)
Date: Fri, 15 Apr 2016 18:36:11 +0800
Subject: [PATCH 3/6] regulator: rk808: Make rk808 generic, rename
 rk808-regulator.c
In-Reply-To: <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
Message-ID: <201604151850.X92LLQkG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wadim,

[auto build test WARNING on regulator/for-next]
[also build test WARNING on v4.6-rc3 next-20160414]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Wadim-Egorov/Add-RK818-PMIC-support/20160415-172610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/regulator/rk8xx-regulator.c:617:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
