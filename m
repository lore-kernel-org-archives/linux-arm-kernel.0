From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Jun 2013 14:50:16 +0200
Subject: [PATCH 0/8] ARM: dts: Add camera and barometer sensor support for
 TRATS2 board
Message-ID: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series includes some fixes and extensions to the Exynos
dts files to add the camera and barometer sensor support for TRATS2
board. It depends on a patch from Tomasz adding initial TRATS2
board dts file [1].

[1] http://www.spinics.net/lists/arm-kernel/msg253184.html

Jacek Anaszewski (1):
  ARM: dts: Add AK8975 device node for Exynos4412 TRATS2 board

Sylwester Nawrocki (7):
  ARM: dts: Correct camera pinctrl nodes for Exynos4x12 SoCs
  ARM: dts: Add pinctrl entries for Exynos4x12 FIMC-IS peripherals
  ARM: dts: Add ISP power domain node for Exynos4x12
  ARM: dts: Use generic DMA bindings for Exynos4 SPI devices
  ARM: dts: Add camera nodes for Exynos4 SoCs
  ARM: dts: Add camera subsystem nodes to exynos4x12.dtsi
  ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board

 arch/arm/boot/dts/exynos4.dtsi            |   80 +++++++++++++++++--
 arch/arm/boot/dts/exynos4412-trats2.dts   |  106 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |   61 ++++++++++++--
 arch/arm/boot/dts/exynos4x12.dtsi         |  123 +++++++++++++++++++++++++++++
 4 files changed, 357 insertions(+), 13 deletions(-)

--
1.7.9.5
