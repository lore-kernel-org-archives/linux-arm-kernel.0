From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Nov 2018 18:42:31 +0800
Subject: [PATCH v2 08/11] clk: mediatek: Add MT8183 clock support
In-Reply-To: <20181127034254.24721-10-weiyi.lu@mediatek.com>
References: <20181127034254.24721-10-weiyi.lu@mediatek.com>
Message-ID: <201811271829.UmmeIHXO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Weiyi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.20-rc4 next-20181126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Weiyi-Lu/Mediatek-MT8183-clock-and-scpsys-support/20181127-114621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/clk/mediatek/clk-mt8183.c:1295:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
