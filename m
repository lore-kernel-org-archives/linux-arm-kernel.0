From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 18:42:18 +0800
Subject: [PATCH 5/6] drivers: perf: hisi: Add support for HiSilicon SoC
 DDRC PMU driver
In-Reply-To: <1498552001-182148-6-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <201706281831.GsZKCdMT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaokun,

[auto build test WARNING on next-20170619]
[also build test WARNING on v4.12-rc7]
[cannot apply to linus/master linux/master arm64/for-next/core v4.12-rc6 v4.12-rc5 v4.12-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shaokun-Zhang/Add-HiSilicon-SoC-uncore-Performance-Monitoring-Unit-driver/20170628-070841


coccinelle warnings: (new ones prefixed by >>)

>> drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c:274:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
