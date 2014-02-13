From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 13 Feb 2014 13:53:58 -0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add hog entry for GPIO4_10
Message-ID: <1392306839-10736-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO4_10 is the GPIO used to turn on the regulator that powers up the codec.

Add a hog entry for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0d816d3..a802265 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -303,6 +303,7 @@
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x80000000
 			>;
 		};
 
-- 
1.8.1.2
