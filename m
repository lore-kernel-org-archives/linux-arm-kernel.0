From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Dec 2012 13:38:34 -0200
Subject: [PATCH 1/2] ARM: dts: imx27-3ds: Rename it to imx27-pdk
Message-ID: <1356190716-21254-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx27-pdk is the name found on Freescale website, so use it instead of 3ds.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} (85%)

diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-pdk.dts
similarity index 85%
rename from arch/arm/boot/dts/imx27-3ds.dts
rename to arch/arm/boot/dts/imx27-pdk.dts
index fa04c7b..860b6f2 100644
--- a/arch/arm/boot/dts/imx27-3ds.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -13,8 +13,8 @@
 /include/ "imx27.dtsi"
 
 / {
-	model = "mx27_3ds";
-	compatible = "freescale,imx27-3ds", "fsl,imx27";
+	model = "Freescale i.MX27 Product Development Kit";
+	compatible = "freescale,imx27-pdk", "fsl,imx27";
 
 	memory {
 		reg = <0x0 0x0>;
-- 
1.7.9.5
