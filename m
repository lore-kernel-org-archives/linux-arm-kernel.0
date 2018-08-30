From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Aug 2018 18:12:59 +0800
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Message-ID: <201808301856.vMNJerSs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Codrin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on at91/at91-next]
[also build test WARNING on v4.19-rc1 next-20180830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Codrin-Ciubotariu/ASoC-Add-driver-for-PROTO-Audio-CODEC-with-a-WM8731/20180830-060610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/atmel/mikroe-proto.c:178:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
