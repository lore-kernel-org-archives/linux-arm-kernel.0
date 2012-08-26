From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 26 Aug 2012 17:29:28 +0530
Subject: [PATCH v3 0/3] ARM: Exynos5: Add support for MSHC controller
Message-ID: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds Exynos5250 platform support for MSHC controllers.

Thomas Abraham (3):
  ARM: Samsung: Add support for MSHC controller clocks
  ARM: Exynos5: Add AUXDATA support for MSHC controllers
  ARM: dts: Add nodes for dw_mmc controllers for Samsung Exynos5250 platforms

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   57 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos5250.dtsi         |   32 ++++++++++++++++
 arch/arm/mach-exynos/clock-exynos5.c      |   45 ++++++++---------------
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    8 ++++
 5 files changed, 113 insertions(+), 30 deletions(-)
