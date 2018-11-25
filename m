From: hao5781286@gmail.com (Hao Zhang)
Date: Mon, 26 Nov 2018 00:20:40 +0800
Subject: [PATCH v3 3/6] ARM: dts: add PWM for Bananapi M2 Ultrar board.
Message-ID: <20181125162040.GA5333@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pwm status for Bananapi M2 Ultrar board and the status
also used as LCD-PWM status.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 438b7b4..d785c9b 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -272,6 +272,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_ch0_pin>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.7.4
