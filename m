From: avinashphilip@ti.com (Philip Avinash)
Date: Fri, 1 Feb 2013 11:07:27 +0530
Subject: [PATCH] ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node
Message-ID: <1359697047-1816-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT field of "interrupts" was mentioned wrongly as "interrupt" in SPI
node. This went unnoticed as spi-omap2 driver not making use of
interrupt. Fixes the typo.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index fbcb90b..cece3ad 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -309,7 +309,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x48030000 0x400>;
-			interrupt = <65>;
+			interrupts = <65>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
 			status = "disabled";
@@ -320,7 +320,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x481a0000 0x400>;
-			interrupt = <125>;
+			interrupts = <125>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
 			status = "disabled";
-- 
1.7.9.5
