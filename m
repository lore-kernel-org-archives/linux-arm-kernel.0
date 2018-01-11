From: hao5781286@gmail.com (hao_zhang)
Date: Thu, 11 Jan 2018 19:33:23 +0800
Subject: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
Message-ID: <20180111113323.GA21976@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pwm pins for r40.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 8c5efe2..6cf6273 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -196,6 +196,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.7.4
