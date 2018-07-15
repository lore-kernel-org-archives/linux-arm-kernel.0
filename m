From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 15 Jul 2018 22:21:53 +0200
Subject: [PATCH] ARM: dts: pxa: change serial node names
Message-ID: <20180715202153.7233-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change from xxuart to serial to normalize the devicetree pxa serial
support.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index f609dbb86abf..a5f9efdd2361 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -95,7 +95,7 @@
 			};
 		};
 
-		ffuart: uart at 40100000 {
+		ffuart: serial at 40100000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40100000 0x30>;
 			interrupts = <22>;
@@ -103,7 +103,7 @@
 			status = "disabled";
 		};
 
-		btuart: uart at 40200000 {
+		btuart: serial at 40200000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40200000 0x30>;
 			interrupts = <21>;
@@ -111,7 +111,7 @@
 			status = "disabled";
 		};
 
-		stuart: uart at 40700000 {
+		stuart: serial at 40700000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40700000 0x30>;
 			interrupts = <20>;
@@ -119,7 +119,7 @@
 			status = "disabled";
 		};
 
-		hwuart: uart at 41100000 {
+		hwuart: serial at 41100000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x41100000 0x30>;
 			interrupts = <7>;
-- 
2.11.0
