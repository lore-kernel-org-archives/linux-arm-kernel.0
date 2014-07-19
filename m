From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 09:51:45 +0900
Subject: [GIT PULL 1/5] Samsung non-critical-fixes for v3.17
Message-ID: <53C9C121.6090403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:

   Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/fixes-for-3.17

for you to fetch changes up to 042b687f880adcca77847688aac35e2e16927944:

   ARM: EXYNOS: Fix build breakge with PM_SLEEP=n (2014-07-19 04:45:02 
+0900)

----------------------------------------------------------------
Samsung non critical fixes for v3.17
- update exynos_defconfig for remove outdated configs and
enable most of the configs used on latest exynos platforms
- fix build breakge for exynos_defconfig with PM_SLEEP=n

----------------------------------------------------------------
Krzysztof Kozlowski (1):
       ARM: EXYNOS: Fix build breakge with PM_SLEEP=n

Sachin Kamat (1):
       ARM: exynos_defconfig: Update exynos_defconfig

  arch/arm/configs/exynos_defconfig | 56 ++++++++++++++++++++++++++++-----
  arch/arm/mach-exynos/platsmp.c    | 66 
+++++++++++++++++++++++++++++++++++++++
  arch/arm/mach-exynos/pm.c         | 66 
---------------------------------------
  3 files changed, 114 insertions(+), 74 deletions(-)
