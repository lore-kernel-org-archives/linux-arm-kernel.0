From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:15:34 +0900
Subject: [GIT PULL 3/7] Samsung pm updates for v3.8
Message-ID: <50B557A6.8010504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

This is including properly enabling pm for exynos5 and I created topic 
branch as per previous Olof's suggestion

It doesn't work without this, please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/pm-samsung

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/pm-samsung

Abhilash Kesavan (3):
       ARM: EXYNOS: fix the hotplug for Cortex-A15
       ARM: EXYNOS: Remove scu_enable from cpuidle
       ARM: EXYNOS: Add flush_cache_all in suspend finisher

Inderpal Singh (2):
       ARM: EXYNOS: Add support for rtc wakeup
       ARM: EXYNOS: Fix soft reboot hang after suspend/resume

  arch/arm/mach-exynos/common.c           |    2 +
  arch/arm/mach-exynos/cpuidle.c          |    3 +-
  arch/arm/mach-exynos/hotplug.c          |   45 
++++++++++++++++++++++++++++--
  arch/arm/mach-exynos/pm.c               |    7 +++++
  arch/arm/plat-samsung/include/plat/pm.h |    2 +
  5 files changed, 55 insertions(+), 4 deletions(-)
