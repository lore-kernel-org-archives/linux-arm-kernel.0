From: s-anna@ti.com (Suman Anna)
Date: Tue, 5 Apr 2016 16:44:09 -0500
Subject: [PATCH 1/4] ARM: dts: DRA7: Enable Timers 13 through 16
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Message-ID: <1459892652-47845-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Timers 13 through 16 have been added previously in
disabled state. These timers are common timers that are
present on all DRA7 family of SoCs, so enable these
devices by default like the rest of the DMTimers.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac88279427..66c7924e5491 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -778,7 +778,6 @@
 			reg = <0x48828000 0x80>;
 			interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer13";
-			status = "disabled";
 		};
 
 		timer14: timer at 4882a000 {
@@ -786,7 +785,6 @@
 			reg = <0x4882a000 0x80>;
 			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer14";
-			status = "disabled";
 		};
 
 		timer15: timer at 4882c000 {
@@ -794,7 +792,6 @@
 			reg = <0x4882c000 0x80>;
 			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer15";
-			status = "disabled";
 		};
 
 		timer16: timer at 4882e000 {
@@ -802,7 +799,6 @@
 			reg = <0x4882e000 0x80>;
 			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer16";
-			status = "disabled";
 		};
 
 		wdt2: wdt at 4ae14000 {
-- 
2.7.4
