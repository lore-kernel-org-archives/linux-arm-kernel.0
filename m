From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:14 +0900
Subject: [PATCH 08/19] ARM: shmobile: emev2 dtsi: Add uart* labels for easier
 referencing
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <e87aabaf24d660e3d4c68cfbd6aae0814b573375.1414556944.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 5fe9212..cc7bfe0 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -137,7 +137,7 @@
 		clock-names = "sclk";
 	};
 
-	serial at e1020000 {
+	uart0: serial at e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -145,7 +145,7 @@
 		clock-names = "sclk";
 	};
 
-	serial at e1030000 {
+	uart1: serial at e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -153,7 +153,7 @@
 		clock-names = "sclk";
 	};
 
-	serial at e1040000 {
+	uart2: serial at e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -161,7 +161,7 @@
 		clock-names = "sclk";
 	};
 
-	serial at e1050000 {
+	uart3: serial at e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.1
