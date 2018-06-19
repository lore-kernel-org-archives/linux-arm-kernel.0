From: lkp@intel.com (kbuild test robot)
Date: Tue, 19 Jun 2018 19:05:06 +0800
Subject: [PATCH v3 7/9] drm/bridge: tc358764: Add DSI to LVDS bridge driver
In-Reply-To: <1529396370-18761-8-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-8-git-send-email-m.purski@samsung.com>
Message-ID: <201806191813.jof7uloL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.18-rc1]
[also build test WARNING on next-20180619]
[cannot apply to drm-exynos/exynos-drm/for-next robh/for-next drm/drm-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/drm-exynos-rename-bridge_node-to-mic_bridge_node/20180619-175136


coccinelle warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/bridge/tc358764.c:179:60-66: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
