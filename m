From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:02 +0100
Subject: [PATCH 23/31] ARM: dts: porter: Always use status "okay" to enable
 devices
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <d8fc23051a9b6dd66ed0cc3c2a676991493b8112.1489999063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While status "ok" does work, the canonical form is "okay", so update the
few places that used the former.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6761d11d3f9e..d9aa2cd6d625 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -226,7 +226,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
@@ -359,7 +359,7 @@
 
 /* composite video input */
 &vin0 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin0_pins>;
 	pinctrl-names = "default";
 
-- 
2.7.0.rc3.207.g0ac5344
