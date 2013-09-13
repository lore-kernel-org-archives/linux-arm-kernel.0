From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Sep 2013 18:13:00 -0300
Subject: [PATCH] ARM: dts: imx6sl: Add spi aliases
Message-ID: <1379106780-17542-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add spi aliases.

While at it, keep the aliases entries sorted.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index bcdbc6c..f295290 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -13,16 +13,20 @@
 
 / {
 	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
 		gpio3 = &gpio4;
 		gpio4 = &gpio5;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		spi0 = &ecspi1;
+		spi1 = &ecspi2;
+		spi2 = &ecspi3;
+		spi3 = &ecspi4;
 	};
 
 	cpus {
-- 
1.8.1.2
