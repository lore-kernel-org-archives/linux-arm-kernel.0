From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Sep 2016 23:10:39 +0800
Subject: [PATCH 1/5] clk: add support for runtime pm
In-Reply-To: <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201609012326.7939xqBY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Marek-Szyprowski/Add-runtime-PM-support-for-clocks-on-Exynos-SoC-example/20160901-215042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/clk/clk.c:123:9-10: WARNING: return of 0/1 in function 'clk_pm_runtime_suspended' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
