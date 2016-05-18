From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 18 May 2016 16:02:03 +0200
Subject: [PATCH 1/1] arm: dts: ls1021a: Fix dspi chip select amount
Message-ID: <1463580123-16713-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSPI periphery has 6 chip selects.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 726372d..1406e98 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -245,7 +245,7 @@
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&platform_clk 1>;
-			spi-num-chipselects = <5>;
+			spi-num-chipselects = <6>;
 			big-endian;
 			status = "disabled";
 		};
@@ -258,7 +258,7 @@
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&platform_clk 1>;
-			spi-num-chipselects = <5>;
+			spi-num-chipselects = <6>;
 			big-endian;
 			status = "disabled";
 		};
-- 
2.7.3
