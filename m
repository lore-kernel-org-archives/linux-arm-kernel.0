From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:00 +0200
Subject: [PATCH 1/6] ARM: dts: am57xx: sbc-am57x: fix SB-SOM EEPROM I2C address
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-2-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix SB-SOM EEPROM I2C address

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 77bb8e1..0f1d425 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -108,9 +108,9 @@
 	pinctrl-0 = <&i2c5_pins_default>;
 	clock-frequency = <400000>;
 
-	eeprom_base: atmel at 50 {
+	eeprom_base: atmel at 54 {
 		compatible = "atmel,24c08";
-		reg = <0x50>;
+		reg = <0x54>;
 		pagesize = <16>;
 	};
 
-- 
1.9.1
