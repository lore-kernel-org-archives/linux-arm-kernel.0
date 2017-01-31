From: lkp@intel.com (kbuild test robot)
Date: Tue, 31 Jan 2017 19:34:11 +0800
Subject: [PATCH v3 3/8] ASoC: Add sun8i digital audio codec
In-Reply-To: <20170131100552.27949-4-mylene.josserand@free-electrons.com>
Message-ID: <201701311952.eSnc2r78%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

[auto build test WARNING on next-20170130]
[also build test WARNING on v4.10-rc6]
[cannot apply to asoc/for-next robh/for-next mripard/sunxi/for-next v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Add-sun8i-A33-audio-driver/20170131-181539


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun8i-codec.c:487:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
