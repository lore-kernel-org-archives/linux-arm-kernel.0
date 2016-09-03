From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  3 Sep 2016 13:05:17 +0200
Subject: [PATCH 1/2] ARM: dts: sun8i: Orange Pi Plus dts is for the Plus and
 Plus 2
Message-ID: <20160903110518.8267-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the sun8i-h3-orangepi-plus.dts model string to reflect that it
is valid for both the Orange Pi Plus and the Orange Pi Plus 2.

This is also meant to help users realize that it is not valid for
the new Orange Pi Plus 2E, which will get its own dts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index b0cb417..bb58591 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -44,7 +44,7 @@
 #include "sun8i-h3-orangepi-2.dts"
 
 / {
-	model = "Xunlong Orange Pi Plus";
+	model = "Xunlong Orange Pi Plus / Plus 2";
 	compatible = "xunlong,orangepi-plus", "allwinner,sun8i-h3";
 
 	reg_usb3_vbus: usb3-vbus {
-- 
2.9.3
