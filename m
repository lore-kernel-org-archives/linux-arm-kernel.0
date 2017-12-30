From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Dec 2017 11:15:43 +0800
Subject: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
In-Reply-To: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
References: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Message-ID: <201712301029.0opO7KPg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.15-rc5 next-20171222]
[cannot apply to input/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/sun8i-a83t-Add-touchscreen-support-on-TBS-A711/20171230-091331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/edt-ft5x06.c:1004:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
