From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Jan 2016 02:30:59 +0100
Subject: [PATCH] ARM: dts: at91: at91sam9n12ek: fix panel compatible string
Message-ID: <1453167059-31247-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Properly use qiaodian as the vendor prefix for the panel

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index ca4ddf86817a..626c67d66626 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -215,7 +215,7 @@
 	};
 
 	panel: panel {
-		compatible = "qd,qd43003c0-40", "simple-panel";
+		compatible = "qiaodian,qd43003c0-40", "simple-panel";
 		backlight = <&backlight>;
 		power-supply = <&panel_reg>;
 		#address-cells = <1>;
-- 
2.5.0
