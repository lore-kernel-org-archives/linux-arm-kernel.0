From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:46:43 +0900
Subject: [PATCH 0/4] ARM: dts: update device tree for exynos5440
Message-ID: <1365072407-4320-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates device tree for exynos5440 including for PMU, PDMA0 and GMAC.

 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    6 +----
 arch/arm/boot/dts/exynos5440.dtsi         |   35 ++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 13 deletions(-)

[PATCH 1/4] ARM: dts: Add node for GMAC for exynos5440
[PATCH 2/4] ARM: dts: add PDMA0 changes for exynos5440
[PATCH 3/4] ARM: dts: add PMU support in exynos5440
[PATCH 4/4] ARM: dts: update bootargs to boot from sda2 for
