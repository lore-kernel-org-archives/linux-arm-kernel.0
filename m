From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Sep 2013 11:12:40 -0300
Subject: [PATCH 1/3] ARM: dts: imx6q-sabrelite: Add ethernet phy reset pin
 into hog
Message-ID: <1380291162-17099-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

MX6QDL_PAD_EIM_D23__GPIO3_IO23 pin is used to reset the ethernet phy.

Add it to the 'hog' group.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index e1c1777..f004913 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -123,6 +123,7 @@
 				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
 				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23	0x80000000
 			>;
 		};
 	};
-- 
1.8.1.2
