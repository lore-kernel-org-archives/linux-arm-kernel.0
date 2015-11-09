From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Nov 2015 11:13:54 +0800
Subject: [PATCH v4 1/2] ASoC: codec: Inno codec driver for RK3036 SoC
In-Reply-To: <1447035020-10332-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <201511091100.MPMFFAtK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ZhengShunQian,

[auto build test WARNING on: asoc/for-next]
[also build test WARNING on: v4.3 next-20151106]

url:    https://github.com/0day-ci/linux/commits/Shunqian-Zheng/Audio-Codec-Driver-of-RK3036-SoC/20151109-101538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/inno_rk3036.c:480:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
