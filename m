From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Tue, 23 Oct 2012 10:37:12 +0200
Subject: [PATCH v2 4/4] ARM: dts: omap5: Update MMC with address space and
 interrupts
In-Reply-To: <1350981432-6750-1-git-send-email-s-guiriec@ti.com>
References: <1350981432-6750-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1350981432-6750-5-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add base address and interrupt line inside Device Tree data for
OMAP5.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 413df94..b643cd3 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -285,6 +285,8 @@
 
 		mmc1: mmc at 4809c000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x4809c000 0x400>;
+			interrupts = <0 83 0x4>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
@@ -292,24 +294,32 @@
 
 		mmc2: mmc at 480b4000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480b4000 0x400>;
+			interrupts = <0 86 0x4>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
 		};
 
 		mmc3: mmc at 480ad000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480ad000 0x400>;
+			interrupts = <0 94 0x4>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 		};
 
 		mmc4: mmc at 480d1000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d1000 0x400>;
+			interrupts = <0 96 0x4>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
 		};
 
 		mmc5: mmc at 480d5000 {
 			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d5000 0x400>;
+			interrupts = <0 59 0x4>;
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
-- 
1.7.10.4
