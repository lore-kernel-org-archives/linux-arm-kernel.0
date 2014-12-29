From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:36 +0900
Subject: [PATCH 2/7] ARM: shmobile: armadillo800eva dts: Replace status value
 "ok" by "okay"
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
Message-ID: <16d3b8845ef3934a0586df5662254d54785d7741.1419809027.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index d4af4d8..9bd0cb4 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -172,7 +172,7 @@
 	pinctrl-names = "default";
 
 	phy-handle = <&phy0>;
-	status = "ok";
+	status = "okay";
 
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
@@ -193,7 +193,7 @@
 };
 
 &cmt1 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-- 
2.1.3
