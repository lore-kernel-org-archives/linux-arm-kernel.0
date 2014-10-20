From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 20 Oct 2014 11:02:13 -0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Use IMX6QDL_CLK_CKO define
Message-ID: <1413810133-21866-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use IMX6QDL_CLK_CKO definition instead of its hard coded clock number for better
readability.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index baf2f00..d211d5d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -179,7 +179,7 @@
 	codec: wm8962 at 1a {
 		compatible = "wlf,wm8962";
 		reg = <0x1a>;
-		clocks = <&clks 201>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
 		DCVDD-supply = <&reg_audio>;
 		DBVDD-supply = <&reg_audio>;
 		AVDD-supply = <&reg_audio>;
-- 
1.9.1
