From: oss@buserror.net (Scott Wood)
Date: Thu, 12 May 2016 23:37:40 -0500
Subject: [PATCH v2 2/2] arm64: dts: Add timer erratum property for LS2080A and
 LS1043A
In-Reply-To: <1463114260-8724-1-git-send-email-oss@buserror.net>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
Message-ID: <1463114260-8724-2-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index be72bf5..596420c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -115,6 +115,7 @@
 			     <1 14 0x1>, /* Physical Non-Secure PPI */
 			     <1 11 0x1>, /* Virtual PPI */
 			     <1 10 0x1>; /* Hypervisor PPI */
+		fsl,erratum-a008585;
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 9d746c6..0270ccf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -171,6 +171,7 @@
 			     <1 14 0x8>, /* Physical Non-Secure PPI, active-low */
 			     <1 11 0x8>, /* Virtual PPI, active-low */
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
+		fsl,erratum-a008585;
 	};
 
 	pmu {
-- 
2.5.0
