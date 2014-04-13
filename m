From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Apr 2014 13:41:05 +0200
Subject: [PATCH 4/4] ARM: sun7i: dt: Add address- and size-cells info to i2c
 controller nodes
In-Reply-To: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
References: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1397389265-22288-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 88d44135..f4b00a5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -848,6 +848,8 @@
 			clocks = <&apb1_gates 0>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -857,6 +859,8 @@
 			clocks = <&apb1_gates 1>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c2: i2c at 01c2b400 {
@@ -866,6 +870,8 @@
 			clocks = <&apb1_gates 2>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c3: i2c at 01c2b800 {
@@ -875,6 +881,8 @@
 			clocks = <&apb1_gates 3>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c4: i2c at 01c2bc00 {
@@ -884,6 +892,8 @@
 			clocks = <&apb1_gates 15>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		gmac: ethernet at 01c50000 {
-- 
1.9.0
