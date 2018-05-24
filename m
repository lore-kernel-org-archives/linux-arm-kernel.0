From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 17:52:57 -0700
Subject: [PATCH] arm64: dt: Update sp805 compatible string
Message-ID: <1527123177-23273-1-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two sp805 binding documents 'arm,sp805.txt' and 'sp805-wdt.txt' are
consolidated into 1 ('arm,sp805.txt'), with the compatible string
consolidated to "arm,sp805", which are already used in all ARM32 dts
and most ARM64 dts files

Update the following dtsi to use the consolidated compatible string
'arm,sp805':

fsl-ls1088a.dtsi
fsl-ls208xa.dtsi
hi3660.dtsi
hi6220.dtsi

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi      |  4 ++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 1c6556b..473c503 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -614,56 +614,56 @@
 		};
 
 		cluster1_core0_watchdog: wdt at c000000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster1_core1_watchdog: wdt at c010000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster1_core2_watchdog: wdt at c020000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc020000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster1_core3_watchdog: wdt at c030000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc030000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core0_watchdog: wdt at c100000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core1_watchdog: wdt at c110000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core2_watchdog: wdt at c120000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc120000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core3_watchdog: wdt at c130000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc130000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..5242ef9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -258,56 +258,56 @@
 		};
 
 		cluster1_core0_watchdog: wdt at c000000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster1_core1_watchdog: wdt at c010000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core0_watchdog: wdt at c100000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core1_watchdog: wdt at c110000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster3_core0_watchdog: wdt at c200000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc200000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster3_core1_watchdog: wdt at c210000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc210000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster4_core0_watchdog: wdt at c300000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc300000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster4_core1_watchdog: wdt at c310000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc310000 0x0 0x1000>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ec3eb8e..dcfa3fe 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -951,7 +951,7 @@
 		};
 
 		watchdog0: watchdog at e8a06000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xe8a06000 0x0 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_OSC32K>;
@@ -959,7 +959,7 @@
 		};
 
 		watchdog1: watchdog at e8a07000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xe8a07000 0x0 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_OSC32K>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 586b281c..beda66b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -816,7 +816,7 @@
 		};
 
 		watchdog0: watchdog at f8005000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
+			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xf8005000 0x0 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ao_ctrl HI6220_WDT0_PCLK>;
-- 
2.1.4
