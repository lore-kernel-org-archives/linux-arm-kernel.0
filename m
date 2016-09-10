From: oss@buserror.net (Scott Wood)
Date: Fri,  9 Sep 2016 20:03:30 -0500
Subject: [PATCH v5 2/5] arm64: dts: Add timer erratum property for LS2080A and
 LS1043A
In-Reply-To: <1473469413-11019-1-git-send-email-oss@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
Message-ID: <1473469413-11019-2-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index e669fbd..952531d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -123,6 +123,7 @@
 			     <1 14 0x1>, /* Physical Non-Secure PPI */
 			     <1 11 0x1>, /* Virtual PPI */
 			     <1 10 0x1>; /* Hypervisor PPI */
+		fsl,erratum-a008585;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 21023a3..9d3ac19 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -195,6 +195,7 @@
 			     <1 14 0x8>, /* Physical Non-Secure PPI, active-low */
 			     <1 11 0x8>, /* Virtual PPI, active-low */
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
+		fsl,erratum-a008585;
 	};
 
 	pmu {
-- 
2.7.4
