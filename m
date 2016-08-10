From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 15:12:59 +0200
Subject: [PATCH 2/4] ARM: dts: STiH407-pinctrl: Update gpio-cells to 2
In-Reply-To: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
References: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470834781-23232-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch allows to use second parameter to the gpio
specifier, which is used to specify whether the gpio is
active high or low.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..5653840 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -58,7 +58,7 @@
 
 			pio0: gpio at 09610000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x100>;
@@ -66,7 +66,7 @@
 			};
 			pio1: gpio at 09611000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x100>;
@@ -74,7 +74,7 @@
 			};
 			pio2: gpio at 09612000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x100>;
@@ -82,7 +82,7 @@
 			};
 			pio3: gpio at 09613000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x3000 0x100>;
@@ -90,7 +90,7 @@
 			};
 			pio4: gpio at 09614000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x4000 0x100>;
@@ -99,7 +99,7 @@
 
 			pio5: gpio at 09615000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x5000 0x100>;
@@ -373,7 +373,7 @@
 
 			pio10: pio at 09200000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x100>;
@@ -381,7 +381,7 @@
 			};
 			pio11: pio at 09201000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x100>;
@@ -389,7 +389,7 @@
 			};
 			pio12: pio at 09202000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x100>;
@@ -397,7 +397,7 @@
 			};
 			pio13: pio at 09203000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x3000 0x100>;
@@ -405,7 +405,7 @@
 			};
 			pio14: pio at 09204000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x4000 0x100>;
@@ -413,7 +413,7 @@
 			};
 			pio15: pio at 09205000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x5000 0x100>;
@@ -421,7 +421,7 @@
 			};
 			pio16: pio at 09206000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x6000 0x100>;
@@ -429,7 +429,7 @@
 			};
 			pio17: pio at 09207000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x7000 0x100>;
@@ -437,7 +437,7 @@
 			};
 			pio18: pio at 09208000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x8000 0x100>;
@@ -445,7 +445,7 @@
 			};
 			pio19: pio at 09209000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x9000 0x100>;
@@ -930,7 +930,7 @@
 
 			pio20: pio at 09210000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x100>;
@@ -951,7 +951,7 @@
 
 			pio30: gpio at 09220000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x0 0x100>;
@@ -959,7 +959,7 @@
 			};
 			pio31: gpio at 09221000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x100>;
@@ -967,7 +967,7 @@
 			};
 			pio32: gpio at 09222000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x100>;
@@ -975,7 +975,7 @@
 			};
 			pio33: gpio at 09223000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x3000 0x100>;
@@ -983,7 +983,7 @@
 			};
 			pio34: gpio at 09224000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x4000 0x100>;
@@ -991,7 +991,7 @@
 			};
 			pio35: gpio at 09225000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x5000 0x100>;
@@ -1090,7 +1090,7 @@
 
 			pio40: gpio at 09230000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0 0x100>;
@@ -1098,7 +1098,7 @@
 			};
 			pio41: gpio at 09231000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x1000 0x100>;
@@ -1106,7 +1106,7 @@
 			};
 			pio42: gpio at 09232000 {
 				gpio-controller;
-				#gpio-cells = <1>;
+				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0x2000 0x100>;
-- 
1.9.1
