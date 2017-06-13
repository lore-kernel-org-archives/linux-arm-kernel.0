From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 08:28:21 +0800
Subject: [PATCH V3 3/7] tty: serial: lpuart: add little endian 32 bit
 register support
In-Reply-To: <1497281848-12995-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201706130841.YZhbOH9x%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.12-rc5 next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/tty-serial-lpuart-add-imx7ulp-support/20170613-045714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing


coccinelle warnings: (new ones prefixed by >>)

>> drivers/tty/serial/fsl_lpuart.c:305:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
