From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 10 Mar 2017 11:39:12 +0100
Subject: [PATCH v2 02/11] ARM: sun8i: a33: add all operating points
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Message-ID: <20170310103921.19469-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds all operating points allowed for the A33 as defined by fex
files available at:
https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 arch/arm/boot/dts/sun8i-a33.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b86f0e7..ba87a9e 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,24 +49,84 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp at 120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp at 720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp at 912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp at 1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1320000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1320000>;
-- 
2.9.3
