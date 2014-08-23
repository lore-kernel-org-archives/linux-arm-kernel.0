From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 23 Aug 2014 10:11:21 +0100
Subject: [PATCH 1/6] ARM: dts: microsom-ar8035: MDIO pad must be set open drain
In-Reply-To: <20140823091058.GO30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
Message-ID: <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabeeh Khoury <rabeeh@solid-run.com>
To: Shawn Guo <shawn.guo@freescale.com>

MDIO pad must be set open drain.

Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index d16066608e21..db9f45b2c573 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -17,7 +17,7 @@
 	enet {
 		pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
 			fsl,pins = <
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
 				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
 				/* AR8035 reset */
 				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
-- 
1.8.3.1
