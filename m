From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 18 Apr 2017 08:01:27 -0700
Subject: [PATCH v2 1/7] ARM: dts: i.MX: Reintroduce 'anatop-enable-bit' where
 appropriate
In-Reply-To: <20170418150133.31679-1-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
Message-ID: <20170418150133.31679-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that support for 'anatop-enable-bit' has been added to ANADIG
driver, reintroduce 'anatop-enable-bit' for all applicable LDOs.

Cc: yurovsky at gmail.com
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx7s.dtsi   | 1 +
 5 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6d7bf64..ec398ea 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -643,6 +643,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -657,6 +658,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -671,6 +673,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2875000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index cc9572e..3243af4 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -530,6 +530,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -544,6 +545,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -558,6 +560,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2850000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index dd4ec85..97199ee 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -586,6 +586,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -600,6 +601,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -614,6 +616,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2875000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d..6da2b77 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -542,6 +542,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 5d3a43b..7148eac 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -517,6 +517,7 @@
 					anatop-min-bit-val = <8>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1200000>;
+					anatop-enable-bit = <0>;
 				};
 			};
 
-- 
2.9.3
