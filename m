From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Apr 2014 16:04:04 +0800
Subject: [PATCH 1/4] ARM: dts: imx: add required #clock-cells for fixed-clock
In-Reply-To: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
References: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1397203447-22965-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per bindings of fixed-clock, #clock-cells is a required property.  Let's
add it for those fixed rate clocks.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi      | 1 +
 arch/arm/boot/dts/imx27-apf27.dts | 1 +
 arch/arm/boot/dts/imx27.dtsi      | 1 +
 arch/arm/boot/dts/imx50.dtsi      | 4 ++++
 arch/arm/boot/dts/imx51.dtsi      | 4 ++++
 arch/arm/boot/dts/imx53.dtsi      | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi    | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi     | 2 ++
 arch/arm/boot/dts/vf610-twr.dts   | 2 ++
 arch/arm/boot/dts/vf610.dtsi      | 2 ++
 10 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 32f760e..ea323f0 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -56,6 +56,7 @@
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index 09f57b3..73aae4f 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -29,6 +29,7 @@
 
 		osc26m {
 			compatible = "fsl,imx-osc26m", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 6279e0b..137e010e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -48,6 +48,7 @@
 
 		osc26m {
 			compatible = "fsl,imx-osc26m", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <26000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 0c75fe3..9c89d1c 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -53,21 +53,25 @@
 
 		ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <22579200>;
 		};
 
 		ckih2 {
 			compatible = "fsl,imx-ckih2", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 5f8216d..150bb4e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -50,21 +50,25 @@
 
 		ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		ckih2 {
 			compatible = "fsl,imx-ckih2", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b57ab577..3d0bfd5 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -70,21 +70,25 @@
 
 		ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <22579200>;
 		};
 
 		ckih2 {
 			compatible = "fsl,imx-ckih2", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 55cb926..8ee6361 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -59,16 +59,19 @@
 
 		ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
 		osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3cb4941..ebaad63 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -81,11 +81,13 @@
 
 		ckil {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		osc {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 7dd1d6e..ded3610 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -25,11 +25,13 @@
 	clocks {
 		audio_ext {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24576000>;
 		};
 
 		enet_ext {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <50000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 8048733..e3db854 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -45,11 +45,13 @@
 
 		sxosc {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
 		fxosc {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
 	};
-- 
1.8.3.2
