From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 27 Oct 2014 22:43:05 +0100
Subject: [PATCH 5/5] ARM: dts: sun7i: Cubietruck: add power supply regulator
 for USB OTG VBUS
In-Reply-To: <cover.1414444953.git.rbyshko@gmail.com>
References: <cover.1414444953.git.rbyshko@gmail.com>
Message-ID: <e5211c01c83a307415ba1db23279fe8b72070314.1414444953.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 1682307..a281d25 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -40,6 +40,7 @@
 		};
 
 		usbphy: phy at 01c13400 {
+			usb0_vbus-supply = <&reg_usb0_vbus>;
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
 			status = "okay";
-- 
2.1.2
