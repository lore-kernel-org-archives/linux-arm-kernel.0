From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 15:57:08 +0200
Subject: [PATCH v3 3/6] arm64: dts: marvell: armada-37xx: Align the compatible
 string
In-Reply-To: <20170613135711.7622-1-gregory.clement@free-electrons.com>
References: <20170613135711.7622-1-gregory.clement@free-electrons.com>
Message-ID: <20170613135711.7622-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cosmetic patch aligns the compatible string when there are on
several lines.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 4d495ec39202..c1076fd0bd9e 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -163,7 +163,7 @@
 
 			pinctrl_nb: pinctrl at 13800 {
 				compatible = "marvell,armada3710-nb-pinctrl",
-				"syscon", "simple-mfd";
+					     "syscon", "simple-mfd";
 				reg = <0x13800 0x100>, <0x13C00 0x20>;
 				gpionb: gpio {
 					#gpio-cells = <2>;
@@ -219,7 +219,7 @@
 
 			pinctrl_sb: pinctrl at 18800 {
 				compatible = "marvell,armada3710-sb-pinctrl",
-				"syscon", "simple-mfd";
+					     "syscon", "simple-mfd";
 				reg = <0x18800 0x100>, <0x18C00 0x20>;
 				gpiosb: gpio {
 					#gpio-cells = <2>;
@@ -294,7 +294,7 @@
 
 			sdhci0: sdhci at d8000 {
 				compatible = "marvell,armada-3700-sdhci",
-				"marvell,sdhci-xenon";
+					     "marvell,sdhci-xenon";
 				reg = <0xd8000 0x300
 				       0x17808 0x4>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
