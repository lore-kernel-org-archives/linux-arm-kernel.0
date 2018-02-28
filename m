From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Feb 2018 16:41:15 -0600
Subject: [PATCH 1/2] arm: dts: replace 'linux,stdout-path' with 'stdout-path'
Message-ID: <20180228224116.2596-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'linux,stdout-path' has been deprecated for some time in favor of
'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
Search and replace all the of occurrences with 'stdout-path'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/animeo_ip.dts                           | 2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi              | 2 +-
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts            | 2 +-
 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 2 +-
 arch/arm/boot/dts/orion5x-linkstation.dtsi                | 2 +-
 arch/arm/boot/dts/orion5x-lswsgl.dts                      | 2 +-
 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts     | 2 +-
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts               | 2 +-
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts              | 2 +-
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts              | 2 +-
 arch/arm/boot/dts/stih407-b2120.dts                       | 2 +-
 arch/arm/boot/dts/stih410-b2120.dts                       | 2 +-
 arch/arm/boot/dts/stih410-b2260.dts                       | 2 +-
 arch/arm/boot/dts/stih418-b2199.dts                       | 2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts                     | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index b67a75179784..d7c841932701 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -24,7 +24,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &usart2;
+		stdout-path = &usart2;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
index 1db517d3d497..2967a748d859 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
@@ -17,7 +17,7 @@
 		     "digi,connectcore-ccxmx51-som", "fsl,imx51";
 
 	chosen {
-		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 585b4f6986c1..7ba317ae899b 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -13,7 +13,7 @@
 
 / {
 	chosen {
-		linux,stdout-path = &uart4;
+		stdout-path = &uart4;
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
index c701e8d16bbb..8c2449da6f00 100644
--- a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
@@ -24,7 +24,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 89ff404a528c..b545d0f228a5 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -30,7 +30,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/orion5x-linkstation.dtsi b/arch/arm/boot/dts/orion5x-linkstation.dtsi
index e9991c83d7b7..ebd93df5d07a 100644
--- a/arch/arm/boot/dts/orion5x-linkstation.dtsi
+++ b/arch/arm/boot/dts/orion5x-linkstation.dtsi
@@ -48,7 +48,7 @@
 / {
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
index ea966ec03dd0..0d97ded66257 100644
--- a/arch/arm/boot/dts/orion5x-lswsgl.dts
+++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
@@ -60,7 +60,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
index ff3484904294..0324cb54939d 100644
--- a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
+++ b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
@@ -24,7 +24,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
index 6fb052507b36..d1817af53e0b 100644
--- a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
@@ -21,7 +21,7 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts b/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
index 1297414dd649..0c9729306089 100644
--- a/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
+++ b/arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
@@ -23,7 +23,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts b/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
index 9e317a4f431c..86f26715b619 100644
--- a/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
+++ b/arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
@@ -23,7 +23,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &uart0;
+		stdout-path = &uart0;
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index c8ad905d0309..9efafe3e9397 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -15,7 +15,7 @@
 
 	chosen {
 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
-		linux,stdout-path = &sbc_serial0;
+		stdout-path = &sbc_serial0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9830be577433..c049c8629341 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -15,7 +15,7 @@
 
 	chosen {
 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
-		linux,stdout-path = &sbc_serial0;
+		stdout-path = &sbc_serial0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c663b70c43a7..57e009c73015 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -16,7 +16,7 @@
 
 	chosen {
 		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
-		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 4e6d915c85ff..8c2916088e21 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -15,7 +15,7 @@
 
 	chosen {
 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
-		linux,stdout-path = &sbc_serial0;
+		stdout-path = &sbc_serial0;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 7198e8cceb0d..5532e40e350a 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -51,7 +51,7 @@
 
 	chosen {
 		bootargs = "console=ttyLP2,115200 clk_ignore_unused init=/linuxrc rw";
-		linux,stdout-path = "&uart2";
+		stdout-path = "&uart2";
 	};
 
 	memory {
-- 
2.14.1
