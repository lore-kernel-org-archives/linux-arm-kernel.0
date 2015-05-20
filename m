From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 20 May 2015 18:20:07 +0800
Subject: [PATCH] arm64: dts: mt8173: fix some indentation
Message-ID: <1432117261-8884-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix indentation nits to make mt8173.dtsi more consistent.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..56a371f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -91,13 +91,13 @@
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 14
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	soc {
@@ -127,7 +127,7 @@
 
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
-					"mediatek,mt6577-sysirq";
+				     "mediatek,mt6577-sysirq";
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
@@ -149,7 +149,7 @@
 
 		uart0: serial at 11002000 {
 			compatible = "mediatek,mt8173-uart",
-					"mediatek,mt6577-uart";
+				     "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -158,7 +158,7 @@
 
 		uart1: serial at 11003000 {
 			compatible = "mediatek,mt8173-uart",
-					"mediatek,mt6577-uart";
+				     "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x400>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -167,7 +167,7 @@
 
 		uart2: serial at 11004000 {
 			compatible = "mediatek,mt8173-uart",
-					"mediatek,mt6577-uart";
+				     "mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x400>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -176,13 +176,12 @@
 
 		uart3: serial at 11005000 {
 			compatible = "mediatek,mt8173-uart",
-					"mediatek,mt6577-uart";
+				     "mediatek,mt6577-uart";
 			reg = <0 0x11005000 0 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
 	};
-
 };
 
-- 
2.2.0.rc0.207.ga3a616c
