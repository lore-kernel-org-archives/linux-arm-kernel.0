From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 May 2017 15:51:39 +0800
Subject: [PATCH v7 18/34] platform: video-mux: include temporary mmio-mux
 support
In-Reply-To: <1495672189-29164-19-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <201705251540.fnn67915%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.12-rc2 next-20170525]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Steve-Longerbeam/i-MX-Media-Driver/20170525-135051
base:   git://linuxtv.org/media_tree.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/media/platform/video-mux.c:246:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
