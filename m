From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Tue, 3 Oct 2017 16:04:15 +0300
Subject: [PATCH] arm64: dts: update the DPAA QBMan nodes
Message-ID: <1507035855-23068-1-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use constants in the interrupt description.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d16b9cc..0f5e9fe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -376,14 +376,14 @@
 		qman: qman at 1880000 {
 			compatible = "fsl,qman";
 			reg = <0x0 0x1880000 0x0 0x10000>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&qman_fqd &qman_pfdr>;
 		};
 
 		bman: bman at 1890000 {
 			compatible = "fsl,bman";
 			reg = <0x0 0x1890000 0x0 0x10000>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&bman_fbpr>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index c8ff0ba..eddee02 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -281,7 +281,7 @@
 		qman: qman at 1880000 {
 			compatible = "fsl,qman";
 			reg = <0x0 0x1880000 0x0 0x10000>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&qman_fqd &qman_pfdr>;
 
 		};
@@ -289,7 +289,7 @@
 		bman: bman at 1890000 {
 			compatible = "fsl,bman";
 			reg = <0x0 0x1890000 0x0 0x10000>;
-			interrupts = <0 45 0x4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&bman_fbpr>;
 
 		};
-- 
2.1.0
