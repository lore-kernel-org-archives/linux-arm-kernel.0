From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Wed, 24 Oct 2012 09:07:14 +0200
Subject: [PATCH v3 4/4] ARM: dts: omap5: Update MMC with address space and
 interrupts
In-Reply-To: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
References: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1351062434-22514-5-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add base address and interrupt line inside Device Tree data for
OMAP5.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b535d8e..304dd8d 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -304,6 +304,9 @@
 
 		mmc1: mmc at 4809c000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x4809c000 0x400>;
+			interrupts = <0 83 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
@@ -311,24 +314,36 @@
 
 		mmc2: mmc at 480b4000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480b4000 0x400>;
+			interrupts = <0 86 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 		};
 
 		mmc3: mmc at 480ad000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480ad000 0x400>;
+			interrupts = <0 94 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 		};
 
 		mmc4: mmc at 480d1000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d1000 0x400>;
+			interrupts = <0 96 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
 		};
 
 		mmc5: mmc at 480d5000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d5000 0x400>;
+			interrupts = <0 59 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
-- 
1.7.10.4
