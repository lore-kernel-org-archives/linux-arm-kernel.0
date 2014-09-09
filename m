From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  9 Sep 2014 13:26:03 +0200
Subject: [PATCH 4/4] ARM: dts: imx28-tx28: add alias for CAN XCVR regulator
In-Reply-To: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
References: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1410261963-27956-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This alias is used by U-Boot to enable/disable the regulator depending
on baseboard type.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 81d4eb4..a5b27c8 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -27,6 +27,7 @@
 		lcdif = &lcdif;
 		lcdif_23bit_pins = &tx28_lcdif_23bit_pins;
 		lcdif_24bit_pins = &lcdif_24bit_pins_a;
+		reg_can_xcvr = &reg_can_xcvr;
 		spi_gpio = &spi_gpio;
 		spi_mxs = &ssp3;
 		stk5led = &user_led;
-- 
1.7.10.4
