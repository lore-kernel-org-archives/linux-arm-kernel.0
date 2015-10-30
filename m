From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri, 30 Oct 2015 15:44:01 +0100
Subject: [PATCH] ARM: BCM5301X: Add missing Netgear R8000 LEDs
Message-ID: <1446216241-27769-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index 446c586..b52927c 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -50,6 +50,36 @@
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-off";
 		};
+
+		wireless {
+			label = "bcm53xx:white:wireless";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		wps {
+			label = "bcm53xx:white:wps";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz-2 {
+			label = "bcm53xx:white:5ghz-2";
+			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb3 {
+			label = "bcm53xx:white:usb3";
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb2 {
+			label = "bcm53xx:white:usb2";
+			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
 	};
 
 	gpio-keys {
-- 
1.8.4.5
