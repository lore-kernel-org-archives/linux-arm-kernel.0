From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:39 +0900
Subject: [GIT PULL 2nd 3/5] Samsung defconfig update for v3.14
Message-ID: <52B5DCAB.204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 54b56e62d20ac0de6e8e12b7efdaf3a1b9b6541c:

   ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8 (2013-12-02 
07:33:38 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-defconfig-2

for you to fetch changes up to 7c7be272ae6413d1dd298e68752f5e34bc9b3eba:

   ARM: exynos_defconfig: Enable S2MPS11 voltage regulator (2013-12-21 
06:27:47 +0900)

----------------------------------------------------------------
Samsung defconfig 2nd update for v3.14
- enable REGULATOR S2MPS11 for Arndale Octa board

----------------------------------------------------------------
Sachin Kamat (1):
       ARM: exynos_defconfig: Enable S2MPS11 voltage regulator

  arch/arm/configs/exynos_defconfig | 1 +
  1 file changed, 1 insertion(+)
