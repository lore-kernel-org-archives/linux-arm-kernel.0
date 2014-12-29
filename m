From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:39 +0900
Subject: [PATCH 5/7] ARM: shmobile: koelsch dts: Replace status value "ok" by
 "okay"
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
Message-ID: <815446d624f692b197ec5dde00cf341196513e03.1419809027.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af16..e2faa62 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -366,7 +366,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
@@ -377,7 +377,7 @@
 };
 
 &cmt0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata0 {
@@ -563,7 +563,7 @@
 
 /* composite video input */
 &vin1 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin1_pins>;
 	pinctrl-names = "default";
 
-- 
2.1.3
