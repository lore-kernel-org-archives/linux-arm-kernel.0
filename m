From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 07:21:56 +0800
Subject: [PATCH] acpi: implement Generic Event Device
In-Reply-To: <1453757387-28154-1-git-send-email-okaya@codeaurora.org>
Message-ID: <201601260728.zwrjxeIK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/acpi-implement-Generic-Event-Device/20160126-053245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/acpi/evged.c:152:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
