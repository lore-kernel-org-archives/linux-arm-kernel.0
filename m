From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed, 31 Aug 2016 15:54:04 +0200
Subject: [PATCH 5/7] dts: sun8i-h3: add UART1-3 to Orange Pi PC
In-Reply-To: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
References: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1472651646-15579-6-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This board has UARTS1-3 exposed on its expansion header

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9..602b012 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -161,6 +161,21 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_a>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_a>;
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
-- 
2.7.4
