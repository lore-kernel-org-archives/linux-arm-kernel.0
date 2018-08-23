From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 23 Aug 2018 16:41:13 +0800
Subject: [PATCH V2 1/2] ARM: dts: imx6ull-14x14-evk: correct machine model name
Message-ID: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6ULL is a lite version of i.MX6UL, its full name
is i.MX6 UltraLiteLite, NOT UlltraLite.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
index 30ef603..0ba6454 100644
--- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -45,7 +45,7 @@
 #include "imx6ul-14x14-evk.dtsi"
 
 / {
-	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
+	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
 	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 };
 
-- 
2.7.4
