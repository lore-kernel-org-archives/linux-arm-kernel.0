From: lkp@intel.com (kbuild test robot)
Date: Mon, 31 Jul 2017 00:43:29 +0800
Subject: [alsa-devel] [PATCH v3 05/12] ASoC: sun4i-i2s: Add regmap fields
 for channels
In-Reply-To: <20170729141753.20174-6-codekipper@gmail.com>
Message-ID: <201707310016.RARC8ov7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20170728]
[cannot apply to v4.13-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/codekipper-gmail-com/ASoC-Add-I2S-support-for-Allwinner-H3-SoCs/20170730-220649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/sunxi/sun4i-i2s.c:740:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
