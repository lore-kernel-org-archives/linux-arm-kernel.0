From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 29 Nov 2016 11:16:57 +0100
Subject: [PATCH v7 8/8] ARM: dts: sun8i-h3: Add HDMI video to the Orange PI 2
In-Reply-To: <cover.1480414715.git.moinejf@free.fr>
References: <cover.1480414715.git.moinejf@free.fr>
Message-ID: <9c50a8f3028ea6eeb03861633e962453dc027049.1480414715.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 047e9e1..7712972 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -105,16 +105,28 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
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
