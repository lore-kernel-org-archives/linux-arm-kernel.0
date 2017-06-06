From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Jun 2017 15:50:50 +0800
Subject: [PATCH 2/2] thermal: add brcmstb AVS TMON driver
In-Reply-To: <20170605210930.65432-3-code@mmayer.net>
Message-ID: <201706061553.IyOv7qkB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

[auto build test WARNING on thermal/next]
[also build test WARNING on v4.12-rc4 next-20170606]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Markus-Mayer/Documentation-devicetree-add-binding-for-Broadcom-STB-AVS-TMON/20170606-133113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/thermal/broadcom/brcmstb_thermal.c:353:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
