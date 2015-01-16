From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Fri, 16 Jan 2015 19:33:41 +0530
Subject: [PATCH v4 5/5] ARM: sunxi: dts: Add PS2 nodes for A20 lime2 board
In-Reply-To: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1421417021-3247-6-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed364d5..3365f12 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -113,6 +113,18 @@
 			status = "okay";
 		};
 
+		ps20: ps2 at 01c2a000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps20_pins_a>;
+			status = "okay";
+		};
+
+		ps21: ps2 at 01c2a400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps21_pins_a>;
+			status = "okay";
+		};
+
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
-- 
1.7.9.5
