From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Aug 2013 07:34:57 +0900
Subject: [GIT PULL 1/2] Samsung cleanup for v3.12
Message-ID: <160001ce9c63$2ab54060$801fc120$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-cleanup-1

for you to fetch changes up to 8c3736e20ee387acefffdfcac560ea23ee6fd4d8:

  ARM: SAMSUNG: Remove unnecessary exynos4_default_sdhci*() (2013-08-19
05:23:32 +0900)

----------------------------------------------------------------
samsung cleanup for v3.12
- cleanup non-dt stuff in exynos
- remove 0x from exynos dt files
- remove unused codes

----------------------------------------------------------------
Jingoo Han (1):
      ARM: SAMSUNG: Remove unnecessary exynos4_default_sdhci*()

Kukjin Kim (1):
      irqchip: exynos: cleanup non-DT stuff in exynos-combiner

Lee Jones (5):
      ARM: dts: Remove '0x's from Exynos4210 DTSI file
      ARM: dts: Remove '0x's from Exynos4x12 DTSI file
      ARM: dts: Remove '0x's from Exynos5250 DTS file
      ARM: dts: Remove '0x's from Exynos5420 DTS file
      ARM: dts: Remove '0x's from Exynos5440 DTS file

Sachin Kamat (1):
      ARM: EXYNOS: Cleanup common.h file

 arch/arm/boot/dts/exynos4210.dtsi          |    2 +-
 arch/arm/boot/dts/exynos4x12.dtsi          |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi          |   14 ++++-----
 arch/arm/boot/dts/exynos5420.dtsi          |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi          |    2 +-
 arch/arm/mach-exynos/common.h              |   43
---------------------------
 arch/arm/plat-samsung/include/plat/sdhci.h |   38 ------------------------
 drivers/irqchip/exynos-combiner.c          |   44
+---------------------------
 8 files changed, 12 insertions(+), 135 deletions(-)
