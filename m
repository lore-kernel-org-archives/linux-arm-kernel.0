From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Oct 2015 21:52:08 +0800
Subject: [RFC 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1444997709-57293-2-git-send-email-ck.hu@mediatek.com>
Message-ID: <201510162146.XrY3ULaf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test WARNING on drm-exynos/exynos-drm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/CK-Hu/Dcumentation-bridge-Add-documentation-for-ps8640-DT-properties/20151016-201658


coccinelle warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/bridge/parade-ps8640.c:480:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
