From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon,  8 Oct 2018 11:14:28 +0800
Subject: [PATCH 4/4] dts/arm64/layerscape: Clean PCIe controller compatible
 strings
In-Reply-To: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181008031428.25293-5-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the wrong compatible string "snps,dw-pcie", in case
match incorrect driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 12 ++++--------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 68ac78c4564d..d3fe0771d3a0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -475,7 +475,7 @@
 		};
 
 		pcie at 3400000 {
-			compatible = "fsl,ls1012a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1012a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 6cc4c87614b6..1b61782df73e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -661,7 +661,7 @@
 		};
 
 		pcie at 3400000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -686,7 +686,7 @@
 		};
 
 		pcie at 3500000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -711,7 +711,7 @@
 		};
 
 		pcie at 3600000 {
-			compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1043a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 3a2a14a8e187..71585aefe1ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -630,7 +630,7 @@
 		};
 
 		pcie at 3400000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -655,7 +655,7 @@
 		};
 
 		pcie at 3500000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -680,7 +680,7 @@
 		};
 
 		pcie at 3600000 {
-			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1046a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612ab56b..10b253c88a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -512,7 +512,7 @@
 		};
 
 		pcie at 3400000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -536,7 +536,7 @@
 		};
 
 		pcie at 3500000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -560,7 +560,7 @@
 		};
 
 		pcie at 3600000 {
-			compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 7c882da3f6b0..a5f668d786b8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -119,7 +119,7 @@
 };
 
 &pcie1 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 	       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -128,7 +128,7 @@
 };
 
 &pcie2 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 	       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -137,7 +137,7 @@
 };
 
 &pcie3 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 	       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -146,7 +146,7 @@
 };
 
 &pcie4 {
-	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible = "fsl,ls2088a-pcie";
 	reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 	       0x38 0x00000000 0x0 0x00002000>; /* configuration space */
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 547a86ec7cd2..d5dd4e7f1099 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -625,8 +625,7 @@
 		};
 
 		pcie1: pcie at 3400000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 108 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -646,8 +645,7 @@
 		};
 
 		pcie2: pcie at 3500000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 113 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -667,8 +665,7 @@
 		};
 
 		pcie3: pcie at 3600000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 118 0x4>; /* Level high type */
 			interrupt-names = "intr";
@@ -688,8 +685,7 @@
 		};
 
 		pcie4: pcie at 3700000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <0 123 0x4>; /* Level high type */
 			interrupt-names = "intr";
-- 
2.17.1
