From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Aug 2013 09:14:31 +0900
Subject: [GIT PULL 1/3] 2nd Round Samsung defconfig for v3.12
Message-ID: <1f7501cea1f1$3c7edb60$b57c9220$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-v2

for you to fetch changes up to c3e566d941636c6b1f8849d403b23d83c0e10901:

  ARM: exynos4_defconfig: remove obsolete exynos4_defconfig (2013-07-24
17:41:50 +0900)

----------------------------------------------------------------
Remove exynos4_defconfig because,
- No more used after disabling exynos non-DT
- exynos_defconfig can support exynos SoCs

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: exynos4_defconfig: remove obsolete exynos4_defconfig

 arch/arm/configs/exynos4_defconfig |   68
------------------------------------
 1 file changed, 68 deletions(-)
 delete mode 100644 arch/arm/configs/exynos4_defconfig
