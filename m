From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 10 Nov 2014 19:55:10 +0100
Subject: [PATCH v2 5/5] ARM: dts: sun7i: Cubietruck: add power supply
 regulator for USB OTG VBUS
In-Reply-To: <cover.1415645258.git.rbyshko@gmail.com>
References: <cover.1415645258.git.rbyshko@gmail.com>
Message-ID: <75c850ce9a46f86bd746205916bbdcae2cf63756.1415645258.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
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
