From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 19 May 2015 21:27:18 +0100
Subject: [PATCH] ARM: dts: mvebu: fix gpio misspelling in some dts files
Message-ID: <1432067238-4682-1-git-send-email-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few of the Marvell armadda/dove/kirkwood dts(i) files appear to
have some gpio options misspelled as gpo.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts         | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 2 +-
 arch/arm/boot/dts/dove.dtsi                      | 4 ++--
 arch/arm/boot/dts/kirkwood-lsxl.dtsi             | 6 +++---
 arch/arm/boot/dts/kirkwood-mplcec4.dts           | 2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts   | 2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts         | 2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi         | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 0f40d5d..f1d644a 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -195,7 +195,7 @@
 &pinctrl {
 	pwr_led_pin: pwr-led-pin {
 		marvell,pins = "mpp63";
-		marvell,function = "gpo";
+		marvell,function = "gpio";
 	};
 
 	stat_led_pins: stat-led-pins {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 00540f2..d36eea4 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -290,7 +290,7 @@
 
 	backup_led_pin: backup-led-pin {
 		marvell,pins = "mpp63";
-		marvell,function = "gpo";
+		marvell,function = "gpio";
 	};
 
 	power_led_pin: power-led-pin {
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index b42b767..c787109 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -338,7 +338,7 @@
 
 	fan_ctrl_high_pin: fan-ctrl-high-pin {
 		marvell,pins = "mpp63";
-		marvell,function = "gpo";
+		marvell,function = "gpio";
 	};
 
 	fan_alarm_pin: fan-alarm-pin {
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 9ad8295..684daa1 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -603,9 +603,9 @@
 					marvell,function = "nand";
 				};
 
-				pmx_nand_gpo: pmx-nand-gpo {
+				pmx_nand_gpio: pmx-nand-gpio {
 					marvell,pins = "mpp_nand";
-					marvell,function = "gpo";
+					marvell,function = "gpio";
 				};
 
 				pmx_i2c1: pmx-i2c1 {
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 5348447..c258ed8 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -11,7 +11,7 @@
 		pinctrl: pin-controller at 10000 {
 			pmx_power_hdd: pmx-power-hdd {
 				marvell,pins = "mpp10";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 			pmx_usb_vbus: pmx-usb-vbus {
 				marvell,pins = "mpp11";
@@ -19,11 +19,11 @@
 			};
 			pmx_fan_high: pmx-fan-high {
 				marvell,pins = "mpp18";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 			pmx_fan_low: pmx-fan-low {
 				marvell,pins = "mpp19";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 			pmx_led_function_blue: pmx-led-function-blue {
 				marvell,pins = "mpp36";
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index f3a9918..7241ff7 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -31,7 +31,7 @@
 		pinctrl: pin-controller at 10000 {
 			pmx_led_health: pmx-led-health {
 				marvell,pins = "mpp7";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 
 			pmx_sata1: pmx-sata1 {
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index f82827d..3ed8f6c 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -45,7 +45,7 @@
 		pin-controller at 10000 {
 			pmx_usb_led: pmx-usb-led {
 				marvell,pins = "mpp12";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 
 			pmx_leds: pmx-leds {
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
index 35a29de..437d97b 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6192.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -46,7 +46,7 @@
 
                         pmx_usb_power: pmx-usb-power {
                                 marvell,pins = "mpp10";
-                                marvell,function = "gpo";
+                                marvell,function = "gio";
                         };
 		};
 
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 8be5b2e..adb5eec 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -48,7 +48,7 @@
 
 			pmx_fanalarm_18: pmx-fanalarm-18 {
 				marvell,pins = "mpp18";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 
 			pmx_hddled_20: pmx-hddled-20 {
@@ -118,7 +118,7 @@
 
 			pmx_fanctrl_33: pmx-fanctrl-33 {
 				marvell,pins = "mpp33";
-				marvell,function = "gpo";
+				marvell,function = "gpio";
 			};
 
 			pmx_fanctrl_34: pmx-fanctrl-34 {
-- 
2.4.1
