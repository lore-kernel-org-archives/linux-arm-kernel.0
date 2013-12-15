From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 05:21:44 +0900
Subject: [GIT PULL 3/7] Samsung defconfig for v3.14
Message-ID: <52AE0F58.1060401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-defconfig

for you to fetch changes up to 54b56e62d20ac0de6e8e12b7efdaf3a1b9b6541c:

   ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8 (2013-12-02 
07:33:38 +0900)

----------------------------------------------------------------
exynos_defconfig updates for v3.14
- increase number of CPU to 8 for EXYNOS SoCs

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
       ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8

  arch/arm/configs/exynos_defconfig | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
