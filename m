From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Mon,  5 Nov 2018 16:46:48 +0800
Subject: [PATCHv2 1/6] arm64: dts: Add the status property disable PCIe
Message-ID: <20181105084653.26597-1-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bao Xiaowei <xiaowei.bao@nxp.com>

Add the status property disable the PCIe, the property will be enable
by bootloader.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
---
v2:
 - no change

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    4 ++++
 5 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 5da732f..21f2b3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -496,6 +496,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504..760d510 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -683,6 +683,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			status = "disabled";
 		};
 
 		pcie at 3500000 {
@@ -708,6 +709,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			status = "disabled";
 		};
 
 		pcie at 3600000 {
@@ -733,6 +735,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50..64d334c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -652,6 +652,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie at 3500000 {
@@ -677,6 +678,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie at 3600000 {
@@ -702,6 +704,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..9deb9cb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -533,6 +533,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie at 3500000 {
@@ -557,6 +558,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie at 3600000 {
@@ -581,6 +583,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		cluster1_core0_watchdog: wdt at c000000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774..5732e3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -648,6 +648,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 4>,
 					<0000 0 0 3 &gic 0 0 0 111 4>,
 					<0000 0 0 4 &gic 0 0 0 112 4>;
+			status = "disabled";
 		};
 
 		pcie2: pcie at 3500000 {
@@ -669,6 +670,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 4>,
 					<0000 0 0 3 &gic 0 0 0 116 4>,
 					<0000 0 0 4 &gic 0 0 0 117 4>;
+			status = "disabled";
 		};
 
 		pcie3: pcie at 3600000 {
@@ -690,6 +692,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 4>,
 					<0000 0 0 3 &gic 0 0 0 121 4>,
 					<0000 0 0 4 &gic 0 0 0 122 4>;
+			status = "disabled";
 		};
 
 		pcie4: pcie at 3700000 {
@@ -711,6 +714,7 @@
 					<0000 0 0 2 &gic 0 0 0 125 4>,
 					<0000 0 0 3 &gic 0 0 0 126 4>,
 					<0000 0 0 4 &gic 0 0 0 127 4>;
+			status = "disabled";
 		};
 
 		sata0: sata at 3200000 {
-- 
1.7.1
