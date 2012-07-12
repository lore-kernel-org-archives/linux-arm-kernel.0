From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 12 Jul 2012 18:28:44 +0530
Subject: ARM: Exynos5: Enable support for DW-MMC controllers
Message-ID: <1342097927-25334-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables device tree based support for the four dw-mmc controllers
on Samsung's Exynos5250 SoC.

Thomas Abraham (3):
  ARM: Samsung: Add support for MSHC controller clocks
  ARM: Exynos5: Add AUXDATA support for MSHC controllers
  ARM: dts: Add nodes for dw_mmc controllers for Samsung Exynos5250 platforms

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   58 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   32 ++++++++++++++++
 arch/arm/mach-exynos/clock-exynos5.c      |   45 ++++++++--------------
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    8 ++++
 5 files changed, 115 insertions(+), 29 deletions(-)
