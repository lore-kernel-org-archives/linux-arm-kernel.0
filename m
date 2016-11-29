From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 11:14:40 +0100
Subject: [PATCH v7 7/8] ARM: dts: sun8i-h3: Add HDMI video to the Banana Pi M2+
In-Reply-To: <cover.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
Message-ID: <80d22d5c43ddd2eda344743e89b4019b6cf31ea2.1480414715.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index c0c49dd..9f3e2f8 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -93,6 +93,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -101,12 +105,20 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.10.2
