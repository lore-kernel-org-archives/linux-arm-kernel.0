From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 18:11:41 +0800
Subject: [PATCH 3/3] ARM: dts: sun5i: hsg-h702: Enable AXP209 USB power supply
In-Reply-To: <1438337501-8773-1-git-send-email-wens@csie.org>
References: <1438337501-8773-1-git-send-email-wens@csie.org>
Message-ID: <1438337501-8773-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 672f88a8bfbe..c69844891027 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -214,6 +214,10 @@
 	status = "okay";
 };
 
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
-- 
2.5.0
