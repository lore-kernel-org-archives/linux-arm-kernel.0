From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 25 Mar 2017 12:53:10 +0000
Subject: [PATCH] ARM: dts: clearfog: keep dts alphabetically ordered
Message-ID: <E1crlBu-0002Gp-V4@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep the clearfog DTS file ordered alphabetically - Florian placed the
MDIO entry after pinctrl, which mis-orders the file.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dts | 38 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index b9ad1641bcf3..e74904bcd0a0 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -183,25 +183,6 @@
 	};
 };
 
-&pinctrl {
-	clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
-		marvell,pins = "mpp46";
-		marvell,function = "ref";
-	};
-	clearfog_dsa0_pins: clearfog-dsa0-pins {
-		marvell,pins = "mpp23", "mpp41";
-		marvell,function = "gpio";
-	};
-	clearfog_spi1_cs_pins: spi1-cs-pins {
-		marvell,pins = "mpp55";
-		marvell,function = "spi1";
-	};
-	rear_button_pins: rear-button-pins {
-		marvell,pins = "mpp34";
-		marvell,function = "gpio";
-	};
-};
-
 &mdio {
 	status = "okay";
 
@@ -261,6 +242,25 @@
 	};
 };
 
+&pinctrl {
+	clearfog_dsa0_clk_pins: clearfog-dsa0-clk-pins {
+		marvell,pins = "mpp46";
+		marvell,function = "ref";
+	};
+	clearfog_dsa0_pins: clearfog-dsa0-pins {
+		marvell,pins = "mpp23", "mpp41";
+		marvell,function = "gpio";
+	};
+	clearfog_spi1_cs_pins: spi1-cs-pins {
+		marvell,pins = "mpp55";
+		marvell,function = "spi1";
+	};
+	rear_button_pins: rear-button-pins {
+		marvell,pins = "mpp34";
+		marvell,function = "gpio";
+	};
+};
+
 &spi1 {
 	/*
 	 * Add SPI CS pins for clearfog:
-- 
2.7.4
