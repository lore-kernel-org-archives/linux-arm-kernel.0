From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Jul 2013 02:11:09 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Drop the chip variant suffix
Message-ID: <1374037869-17443-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6qdl-sabresd.dtsi is a common file for mx6q and mx6dl versions of sabresd
board, so let's get rid of the 'quad' reference in the compatible string.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 4dec80c..f70db40 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -52,7 +52,7 @@
 	};
 
 	sound {
-		compatible = "fsl,imx6q-sabresd-wm8962",
+		compatible = "fsl,imx6-sabresd-wm8962",
 			   "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
 		ssi-controller = <&ssi2>;
-- 
1.8.1.2
