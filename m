From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Nov 2018 12:02:13 +0800
Subject: [PATCH v2 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
In-Reply-To: <1543335937-12689-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1543335937-12689-4-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <201811281205.lpne37p2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei.Stefanescu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on regulator/for-next]
[also build test WARNING on v4.20-rc4 next-20181127]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrei-Stefanescu-microchip-com/add-support-for-MCP16502-PMIC/20181128-041809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/regulator/mcp16502.c:530:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
