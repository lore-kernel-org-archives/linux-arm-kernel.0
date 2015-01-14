From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 14 Jan 2015 08:20:48 +0100
Subject: [PATCH] ARM: BCM5301X: Drop unused poll-interval from gpio-keys
Message-ID: <1421220049-12175-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was accidentally left (& copied & pasted all around) from our
experiments with gpio-keys-polled.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 1 -
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 1 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 1 -
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 1 -
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index 5fc0fae..13d51a9 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -27,7 +27,6 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <200>;
 
 		restart {
 			label = "Reset";
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 4ed7de1..f18c9d9 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -71,7 +71,6 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <200>;
 
 		wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 12fc2a01..3991042 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -61,7 +61,6 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <200>;
 
 		wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index fb76378..0ee85ea 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -61,7 +61,6 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <200>;
 
 		restart {
 			label = "Reset";
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index bbb414f..e23dbbf 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -27,7 +27,6 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		poll-interval = <200>;
 
 		aoss {
 			label = "AOSS";
-- 
1.8.4.5
