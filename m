From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 16 Aug 2012 01:40:40 +0530
Subject: [PATCH 0/2] Enable pinctrl driver support for Exynos4210 based
 platforms
Message-ID: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables support for pin controller driver for Exynos4210 SoC
based device tree enabled platforms. The first patch in this series adds the
pin group nodes for each of the three pin controller instances, but it is not
a exhaustive list of all possible pin group nodes. As the coverage of pinctrl
driver is extended device drivers used on Exynos4210 platforms, additional
pin group nodes can be added as required.

Thomas Abraham (2):
  ARM: dts: Add pinctrl node entries for Samsung Exynos4210 SoC
  ARM: EXYNOS: Enable PINCTRL config option for Exynos4 device tree enabled platform

 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  457 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         |   37 +++
 arch/arm/mach-exynos/Kconfig              |    1 +
 3 files changed, 495 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl.dtsi
