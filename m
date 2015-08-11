From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 11 Aug 2015 12:46:20 +0900
Subject: [PATCH 0/4] ARM: dts: exynos3250: Add UART2 and MMC2 dt node with
 related clocks
Message-ID: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the UART2 / MMC2 devicetree node for Exynos3250 SoC and add
the related clocks (mux, divider, gate) of UART2 / MMC2 device.

Chanwoo Choi (4):
  clk: samsung: exynos3250: Add UART2 clock
  clk: samsung: exynos3250: Add MMC2 clock
  ARM: dts: Add UART2 dt node for Exynos3250 SoC
  ARM: dts: Add MSHC2 dt node for Exynos3250 SoC

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 42 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi         | 25 ++++++++++++++++++
 drivers/clk/samsung/clk-exynos3250.c      | 15 +++++++++++
 include/dt-bindings/clock/exynos3250.h    | 11 +++++++-
 4 files changed, 92 insertions(+), 1 deletion(-)

-- 
1.8.5.5
