From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Sep 2014 17:18:41 +0900
Subject: [GIT PULL 2/2] Exynos PM updates for v3.18
Message-ID: <54227E61.5060909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-pm

for you to fetch changes up to c3294253713cbc96df59a7cc6a9a3fc0c4ae5ba7:

   ARM: EXYNOS: Refactor the pm code to use DT based lookup (2014-09-24 
16:45:14 +0900)

----------------------------------------------------------------
PM related updates for exynos v3.18

- Refactor the pm code to use DT based lookup instead of
   using "soc_is_exynosxxxx"
- While at it, move exynos5250 specific disabling of JPEG
   USE_RETENTION to pmu.c

----------------------------------------------------------------
Vikas Sajjan (2):
       ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 
to pmu.c
       ARM: EXYNOS: Refactor the pm code to use DT based lookup

  arch/arm/mach-exynos/pm.c       | 172 
+++++++++++++++++++++++++++++-----------
  arch/arm/mach-exynos/pmu.c      |   1 +
  arch/arm/mach-exynos/regs-pmu.h |   1 +
  3 files changed, 127 insertions(+), 47 deletions(-)
