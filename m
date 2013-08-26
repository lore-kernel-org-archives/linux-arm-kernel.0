From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Aug 2013 09:14:42 +0900
Subject: [GIT PULL 3/3] 2nd Round Samsung mach-exynos for v3.12
Message-ID: <1f7701cea1f1$431f2d30$c95d8790$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-mach-exynos

for you to fetch changes up to f52616f4233d71d0fb00f06f86d046d18d2b7f3b:

  ARM: EXYNOS: always enable PM domains support for EXYNOS4X12 (2013-08-19
05:05:16 +0900)

----------------------------------------------------------------
update mach-exynos
- enable ARCH_HAS_BANDGAP for exynos SoCs
- skip C1 cpuidle for exynos5440 because non-supporting
- always enable PM domains for exynos4x12

----------------------------------------------------------------
Amit Daniel Kachhap (2):
      ARM: EXYNOS: enable ARCH_HAS_BANDGAP
      ARM: EXYNOS: Skip C1 cpuidle state for exynos5440

Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: always enable PM domains support for EXYNOS4X12

 arch/arm/mach-exynos/Kconfig   |    7 +++++++
 arch/arm/mach-exynos/cpuidle.c |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)
