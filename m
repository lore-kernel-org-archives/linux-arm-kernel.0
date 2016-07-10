From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 10 Jul 2016 11:24:05 +0200
Subject: [PATCH v2 4/4] ARM: dts: meson8b: Add Meson8b PWM Controller nodes
In-Reply-To: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
References: <1468142645-4360-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1468142645-4360-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index fc4080d..41fd536 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -162,6 +162,27 @@
 			reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
 		};
 
+		pwm_ab: pwm at 8550 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc1108550 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm_cd: pwm at 8650 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc1108650 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm_ef: pwm at 86c0 {
+			compatible = "amlogic,meson8b-pwm";
+			reg = <0xc11086c0 0x10>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pinctrl_cbus: pinctrl at c1109880 {
 			compatible = "amlogic,meson8b-cbus-pinctrl";
 			reg = <0xc1109880 0x10>;
-- 
2.7.0
