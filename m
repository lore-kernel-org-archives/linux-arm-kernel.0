From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Aug 2012 20:22:45 -0300
Subject: [PATCH] ARM: imx27-phytec-phycore: Fix I2C EEPROM address
Message-ID: <1346196165-5024-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix I2C EEPROM address as per 24c32 datasheet.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index 2b0ff60..2acc86c 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -49,7 +49,7 @@
 			i2c at 1001d000 {
 				clock-frequency = <400000>;
 				status = "okay";
-				at24 at 4c {
+				at24 at 52 {
 					compatible = "at,24c32";
 					pagesize = <32>;
 					reg = <0x52>;
-- 
1.7.9.5
