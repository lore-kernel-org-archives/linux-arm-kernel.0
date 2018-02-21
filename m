From: lkp@intel.com (kbuild test robot)
Date: Wed, 21 Feb 2018 23:05:29 +0800
Subject: [PATCH v2 08/10] drm/panel: Add Huarui LHR050H41 panel driver
In-Reply-To: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
References: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <201802212241.kQKqkwNt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/drm-sun4i-Allwinner-MIPI-DSI-support/20180221-203150
base:    
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/panel/panel-huarui-lhr050h41.c:69:24: sparse: symbol 'lhr050h41_init' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
