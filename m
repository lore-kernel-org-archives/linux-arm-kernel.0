From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Apr 2014 13:41:04 +0200
Subject: [PATCH 3/4] ARM: sun5i: dt: Add address- and size-cells info to i2c
 controller nodes
In-Reply-To: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
References: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1397389265-22288-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ea9fd4b..b76b28e 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -503,6 +503,8 @@
 			clocks = <&apb1_gates 0>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c1: i2c at 01c2b000 {
@@ -512,6 +514,8 @@
 			clocks = <&apb1_gates 1>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		i2c2: i2c at 01c2b400 {
@@ -521,6 +525,8 @@
 			clocks = <&apb1_gates 2>;
 			clock-frequency = <100000>;
 			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		timer at 01c60000 {
-- 
1.9.0
