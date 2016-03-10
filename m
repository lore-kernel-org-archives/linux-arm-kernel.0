From: Gang.Liu@nxp.com (Liu Gang)
Date: Thu, 10 Mar 2016 16:57:20 +0800
Subject: [PATCH] gpio/ls1043a: Correct ls1043a gpio nodes compatible in dts
 file
In-Reply-To: <1457600240-47141-1-git-send-email-Gang.Liu@nxp.com>
References: <1457600240-47141-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <1457600240-47141-2-git-send-email-Gang.Liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ls1043a belongs to the Freescale QorIQ platform, and QorIQ
platform's gpio nodes should use compatible "fsl,qoriq-gpio".

Signed-off-by: Liu Gang <Gang.Liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 42a6154..e356362 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -284,7 +284,7 @@
 		};
 
 		gpio1: gpio at 2300000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <0 66 0x4>;
 			gpio-controller;
@@ -294,7 +294,7 @@
 		};
 
 		gpio2: gpio at 2310000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <0 67 0x4>;
 			gpio-controller;
@@ -304,7 +304,7 @@
 		};
 
 		gpio3: gpio at 2320000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <0 68 0x4>;
 			gpio-controller;
@@ -314,7 +314,7 @@
 		};
 
 		gpio4: gpio at 2330000 {
-			compatible = "fsl,ls1043a-gpio";
+			compatible = "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <0 134 0x4>;
 			gpio-controller;
-- 
2.1.0.27.g96db324
