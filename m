From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 11 Nov 2015 14:32:44 +0100
Subject: [PATCH] ARM: dts: imx25: add alias for pwm nodes
Message-ID: <1447248764-17005-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This, together with the corresponding patch to pwm-imx.c,  allows to order the
pwm devices correctly.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 677f81d9dcd5..cde329e9b9e3 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -24,6 +24,10 @@
 		i2c2 = &i2c3;
 		mmc0 = &esdhc1;
 		mmc1 = &esdhc2;
+		pwm0 = &pwm1;
+		pwm1 = &pwm2;
+		pwm2 = &pwm3;
+		pwm3 = &pwm4;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
-- 
2.6.1
