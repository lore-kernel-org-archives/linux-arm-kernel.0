From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:20:05 +0900
Subject: [GIT PULL 10/10] devel-samsung for v3.10
Message-ID: <51630A55.6030703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/devel-samsung-for-v3.10

for you to fetch changes up to 298591f89fd0f3f779a77e589ce2f1c28e9788ed:

   ARM: EXYNOS: replace cpumask by the corresponding macro (2013-04-09 
00:44:35 +0900)

----------------------------------------------------------------
including various development for samsung for v3.10

----------------------------------------------------------------
Charles Keepax (2):
       ARM: S3C64XX: Clear DMA flags on channel request
       ARM: S3C64XX: Slow down mic detection rate for wm5102

Daniel Lezcano (3):
       ARM: EXYNOS: factor out the idle states
       ARM: EXYNOS: handle properly the return values
       ARM: EXYNOS: replace cpumask by the corresponding macro

Inderpal Singh (2):
       ARM: EXYNOS: Add support for rtc wakeup
       ARM: SAMSUNG: check processor type before cache restoration in resume

Jonathan Kliegman (2):
       ARM: EXYNOS: Remove hardcode wakeup unmask for EINT_0
       ARM: EXYNOS: Clear ENABLE_WAKEUP_SW bit when entering suspend

Sylwester Nawrocki (2):
       ARM: SAMSUNG: Export MIPI CSIS/DSIM PHY control functions
       ARM: S3C24XX: Correct NR_IRQS definition for s3c2440

  arch/arm/mach-exynos/common.c                |  2 +
  arch/arm/mach-exynos/cpuidle.c               | 58 
+++++++++++++---------------
  arch/arm/mach-exynos/include/mach/pm-core.h  |  9 +----
  arch/arm/mach-s3c24xx/include/mach/irqs.h    |  4 +-
  arch/arm/mach-s3c64xx/dma.c                  |  1 +
  arch/arm/mach-s3c64xx/mach-crag6410-module.c |  1 +
  arch/arm/plat-samsung/s5p-sleep.S            |  9 +++++
  arch/arm/plat-samsung/setup-mipiphy.c        |  3 ++
  8 files changed, 45 insertions(+), 42 deletions(-)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
