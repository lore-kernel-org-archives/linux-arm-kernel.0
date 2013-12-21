From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:57 +0900
Subject: [GIT PULL 2nd 5/5] Samsung SoC update for v3.14
Message-ID: <52B5DCBD.5020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 538cfbb4c40ab59688236484138133b8e3e89220:

   ARM: dts: Add initial support for Arndale Octa board (2013-12-16 
05:05:43 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-soc-2

for you to fetch changes up to 7a28f198735d040f4d318511827d913d4b53f355:

   ARM: dts: add board dts file for EXYNOS4412 based TINY4412 board 
(2013-12-19 05:34:26 +0900)

----------------------------------------------------------------
Samsung SoC 2nd update for v3.14
- add exynos4412-tiny4412 board dt
   for FriendlyARM's TINY4412 board

----------------------------------------------------------------
Alex Ling (1):
       ARM: dts: add board dts file for EXYNOS4412 based TINY4412 board

  arch/arm/boot/dts/Makefile                |  1 +
  arch/arm/boot/dts/exynos4412-tiny4412.dts | 93 
+++++++++++++++++++++++++++++++
  2 files changed, 94 insertions(+)
  create mode 100644 arch/arm/boot/dts/exynos4412-tiny4412.dts
