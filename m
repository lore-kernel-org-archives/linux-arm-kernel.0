From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  1 Apr 2012 13:51:37 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q-sabrelite: Add bootargs field
Message-ID: <1333299098-2847-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bootargs field.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 4663a4e..73915dc 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -17,6 +17,10 @@
 	model = "Freescale i.MX6 Quad SABRE Lite Board";
 	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
 
+	chosen {
+		bootargs = "console=ttymxc1,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
-- 
1.7.1
