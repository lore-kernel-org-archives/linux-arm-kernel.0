From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 May 2015 12:13:40 +0200
Subject: [PATCH 3/3] ARM: sunxi: dt: Fix whitespace errors
In-Reply-To: <1430648020-8328-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1430648020-8328-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1430648020-8328-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few lines (probably copy pasted) have an indentation mixing tabs and
spaces that triggers a checkpatch warning.

Fix those, and while we're at it, fix the space-indented sections.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 10 +++++-----
 arch/arm/boot/dts/sun5i-a13.dtsi | 12 ++++++------
 arch/arm/boot/dts/sun5i.dtsi     |  2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++-----
 arch/arm/boot/dts/sun7i-a20.dtsi | 18 +++++++++---------
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index c4fdb3b51e58..0a5390eb77cc 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -107,11 +107,11 @@
 			clocks = <&cpu>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
-				/* kHz    uV */
+				/* kHz	  uV */
 				1008000 1400000
-				912000  1350000
-				864000  1300000
-				624000  1250000
+				912000	1350000
+				864000	1300000
+				624000	1250000
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
@@ -431,7 +431,7 @@
 
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
-		        #reset-cells = <1>;
+			#reset-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 1eeadea3ce2f..976d4faa2179 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -139,13 +139,13 @@
 &cpu0 {
 	clock-latency = <244144>; /* 8 32k periods */
 	operating-points = <
-		/* kHz    uV */
+		/* kHz	  uV */
 		1008000 1400000
-		912000  1350000
-		864000  1300000
-		624000  1200000
-		576000  1200000
-		432000  1200000
+		912000	1350000
+		864000	1300000
+		624000	1200000
+		576000	1200000
+		432000	1200000
 		>;
 	#cooling-cells = <2>;
 	cooling-min-level = <0>;
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index fb20ace0a03a..5f662435a935 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -277,7 +277,7 @@
 
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
-		        #reset-cells = <1>;
+			#reset-cells = <1>;
 			compatible = "allwinner,sun5i-a13-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 9ec3f7a5b6e0..008047a018cf 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -100,11 +100,11 @@
 			clocks = <&cpu>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
-				/* kHz    uV */
+				/* kHz	  uV */
 				1008000	1200000
-				864000  1200000
-				720000  1100000
-				480000  1000000
+				864000	1200000
+				720000	1100000
+				480000	1000000
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
@@ -380,7 +380,7 @@
 
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
-		        #reset-cells = <1>;
+			#reset-cells = <1>;
 			compatible = "allwinner,sun6i-a31-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&osc24M>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 19a95a8dd355..8604bf8524fd 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -100,14 +100,14 @@
 			clocks = <&cpu>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
-				/* kHz    uV */
-				960000  1400000
-				912000  1400000
-				864000  1300000
-				720000  1200000
-				528000  1100000
-				312000  1000000
-				144000  900000
+				/* kHz	  uV */
+				960000	1400000
+				912000	1400000
+				864000	1300000
+				720000	1200000
+				528000	1100000
+				312000	1000000
+				144000	900000
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
@@ -444,7 +444,7 @@
 
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
-		        #reset-cells = <1>;
+			#reset-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
-- 
2.3.6
