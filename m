From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Apr 2014 19:25:44 -0300
Subject: [PATCH 1/3] ARM: dts: imx27-pdk: Pass the memory range
Message-ID: <1396477546-11130-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx27-pdk has 128 MB of DRAM. Pass the memory range in dt.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-pdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 5ce89aa..28c83bc 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -17,7 +17,7 @@
 	compatible = "fsl,imx27-pdk", "fsl,imx27";
 
 	memory {
-		reg = <0x0 0x0>;
+		reg = <0xa0000000 0x08000000>;
 	};
 };
 
-- 
1.8.3.2
