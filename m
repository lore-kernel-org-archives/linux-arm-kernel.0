From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jun 2012 17:08:04 +0100
Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
 for DB8500 based devices
In-Reply-To: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
Message-ID: <4FD8BAE4.4050606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 13 Jun 2012 16:21:14 +0100
Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
 for DB8500 based devices

For correct operation of the i2c-nomadik driver, it requires some
information surrounding clock-frequencies, delay times and thresholds.
Here we apply those configurations to be used when a platform is
booted via the device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 00a4c3e..f3050f1 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -455,6 +455,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			v-i2c-supply = <&db8500_vape_reg>;
+
+			clock-frequency = <100000>;
+			stericsson,slsu = <0xe>;
+			stericsson,tft = <1>;
+			stericsson,rft = <8>;
+			stericsson,timeout = <200>;
+			stericsson,i2c_freq_mode_fast;
 		};
 
 		i2c at 80122000 {
@@ -464,6 +471,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			v-i2c-supply = <&db8500_vape_reg>;
+
+			clock-frequency = <100000>;
+			stericsson,slsu = <0xe>;
+			stericsson,tft = <1>;
+			stericsson,rft = <8>;
+			stericsson,timeout = <200>;
+			stericsson,i2c_freq_mode_fast;
 		};
 
 		i2c at 80128000 {
@@ -473,6 +487,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			v-i2c-supply = <&db8500_vape_reg>;
+
+			clock-frequency = <100000>;
+			stericsson,slsu = <0xe>;
+			stericsson,tft = <1>;
+			stericsson,rft = <8>;
+			stericsson,timeout = <200>;
+			stericsson,i2c_freq_mode_fast;
 		};
 
 		i2c at 80110000 {
@@ -482,6 +503,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			v-i2c-supply = <&db8500_vape_reg>;
+
+			clock-frequency = <100000>;
+			stericsson,slsu = <0xe>;
+			stericsson,tft = <1>;
+			stericsson,rft = <8>;
+			stericsson,timeout = <200>;
+			stericsson,i2c_freq_mode_fast;
 		};
 
 		i2c at 8012a000 {
@@ -491,6 +519,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			v-i2c-supply = <&db8500_vape_reg>;
+
+			clock-frequency = <100000>;
+			stericsson,slsu = <0xe>;
+			stericsson,tft = <1>;
+			stericsson,rft = <8>;
+			stericsson,timeout = <200>;
+			stericsson,i2c_freq_mode_fast;
 		};
 
 		ssp at 80002000 {
-- 
1.7.9.5
