From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 05:00:14 +0900
Subject: [GIT PULL 5/5] Samsung drivers-2 for 3.16
Message-ID: <5388E34E.5050703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9dfa92ec4033c348aae6bafc1881e07229fabaa6:

   ARM: EXYNOS: Enable multi-platform build support (2014-05-31 02:43:51 
+0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-drivers-2

for you to fetch changes up to 4c8d819343461d3c3b8d99874cb2ae0ec59ad34a:

   cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM 
(2014-05-31 03:00:25 +0900)

----------------------------------------------------------------
Samsung 2nd drivers for 3.16

This is including fix exynos cpufreq driver compilation with
ARCH_MULTIPLATFORM. Even though this is a work around, this
is required for support exynos multiplatform for a while and
will be updated in near future.

This is based on tags/samsung-exynos.

----------------------------------------------------------------
Tomasz Figa (1):
       cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM

  drivers/cpufreq/Kconfig.arm          |  6 ++---
  drivers/cpufreq/exynos-cpufreq.c     |  2 --
  drivers/cpufreq/exynos-cpufreq.h     | 30 ++++++++++++-------------
  drivers/cpufreq/exynos4210-cpufreq.c | 39 +++++++++++++++++++++++++++-----
  drivers/cpufreq/exynos4x12-cpufreq.c | 40 
++++++++++++++++++++++++++++-----
  drivers/cpufreq/exynos5250-cpufreq.c | 43 
+++++++++++++++++++++++++++++-------
  6 files changed, 119 insertions(+), 41 deletions(-)
