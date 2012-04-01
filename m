From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  1 Apr 2012 13:54:13 -0300
Subject: [PATCH] ARM: dts: imx: Remove bootargs field
Message-ID: <1333299253-2896-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove bootargs field as this information is retrieved from the bootloader.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx51-babbage.dts |    4 ----
 arch/arm/boot/dts/imx53-ard.dts     |    4 ----
 arch/arm/boot/dts/imx53-evk.dts     |    4 ----
 arch/arm/boot/dts/imx53-qsb.dts     |    4 ----
 arch/arm/boot/dts/imx53-smd.dts     |    4 ----
 arch/arm/boot/dts/imx6q-arm2.dts    |    4 ----
 6 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 9949e60..fd729d4 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX51 Babbage Board";
 	compatible = "fsl,imx51-babbage", "fsl,imx51";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
-	};
-
 	memory {
 		reg = <0x90000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 2dccce4..4c61b7f 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX53 Automotive Reference Design Board";
 	compatible = "fsl,imx53-ard", "fsl,imx53";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
-	};
-
 	memory {
 		reg = <0x70000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 5bac4aa..8ce5fe1 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX53 Evaluation Kit";
 	compatible = "fsl,imx53-evk", "fsl,imx53";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
-	};
-
 	memory {
 		reg = <0x70000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 5c57c86..de34a17 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX53 Quick Start Board";
 	compatible = "fsl,imx53-qsb", "fsl,imx53";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
-	};
-
 	memory {
 		reg = <0x70000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index c7ee86c..a984fa5 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX53 Smart Mobile Reference Design Board";
 	compatible = "fsl,imx53-smd", "fsl,imx53";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
-	};
-
 	memory {
 		reg = <0x70000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..1b2b64f 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -17,10 +17,6 @@
 	model = "Freescale i.MX6 Quad Armadillo2 Board";
 	compatible = "fsl,imx6q-arm2", "fsl,imx6q";
 
-	chosen {
-		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk3p3 rootwait";
-	};
-
 	memory {
 		reg = <0x10000000 0x80000000>;
 	};
-- 
1.7.1
