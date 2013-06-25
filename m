From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:55 +0200
Subject: [PATCH 11/16] ARM: dts: i.MX51: Add i2c and spi aliases
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-12-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to order the i2c and spi devices correctly.
While at it reorder the aliases entries alphabetically.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index cb6e09b..f64c87e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -15,13 +15,18 @@
 
 / {
 	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
 		gpio3 = &gpio4;
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		spi0 = &ecspi1;
+		spi1 = &ecspi2;
+		spi2 = &cspi;
 	};
 
 	tzic: tz-interrupt-controller at e0000000 {
-- 
1.8.3.1
