From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:04 +0100
Subject: [PATCH 07/41] ARM: ux500: Supply the GPIO clocks lookup to the DBX500
 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 8a80eb4..089b446 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -78,6 +78,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <0>;
+
+			clocks = <&prcc_pclk 1 9>;
 		};
 
 		gpio1: gpio at 8012e080 {
@@ -91,6 +93,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <1>;
+
+			clocks = <&prcc_pclk 1 9>;
 		};
 
 		gpio2: gpio at 8000e000 {
@@ -104,6 +108,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <2>;
+
+			clocks = <&prcc_pclk 3 8>;
 		};
 
 		gpio3: gpio at 8000e080 {
@@ -117,6 +123,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <3>;
+
+			clocks = <&prcc_pclk 3 8>;
 		};
 
 		gpio4: gpio at 8000e100 {
@@ -130,6 +138,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <4>;
+
+			clocks = <&prcc_pclk 3 8>;
 		};
 
 		gpio5: gpio at 8000e180 {
@@ -143,6 +153,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <5>;
+
+			clocks = <&prcc_pclk 3 8>;
 		};
 
 		gpio6: gpio at 8011e000 {
@@ -156,6 +168,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <6>;
+
+			clocks = <&prcc_pclk 2 1>;
 		};
 
 		gpio7: gpio at 8011e080 {
@@ -169,6 +183,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <7>;
+
+			clocks = <&prcc_pclk 2 1>;
 		};
 
 		gpio8: gpio at a03fe000 {
@@ -182,6 +198,8 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-bank = <8>;
+
+			clocks = <&prcc_pclk 6 1>;
 		};
 
 		pinctrl {
-- 
1.8.1.2
