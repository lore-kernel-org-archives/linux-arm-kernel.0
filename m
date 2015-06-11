From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Jun 2015 13:56:32 +0200
Subject: [PATCH] ARM: mvebu: adjust Armada XP DT spi muxing after pinctrl
 function rename
Message-ID: <1434023792-20455-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the merge of "pinctrl: mvebu: armada-xp: rename spi to spi0"
by Linus Walleij, we need to adjust the Armada XP Device Tree
accordingly, by adjusting the pinctrl configuration for SPI pins.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 013d63f..dba8d3f 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -289,7 +289,7 @@
 	spi0_pins: spi0-pins {
 		marvell,pins = "mpp36", "mpp37",
 			       "mpp38", "mpp39";
-		marvell,function = "spi";
+		marvell,function = "spi0";
 	};
 
 	uart2_pins: uart2-pins {
-- 
2.1.0
