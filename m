From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Apr 2013 16:27:30 +0100
Subject: [RFC PATCH v2 08/13] ARM: mach-picoxcell: cpus/cpu nodes dts updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1366644455-16550-9-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi | 2 +-
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
index f0a8c20..978dbdf 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
@@ -22,7 +22,7 @@
 		#size-cells = <0>;
 
 		cpu at 0 {
-			compatible = "arm,1176jz-s";
+			compatible = "arm,arm1176";
 			clock-frequency = <400000000>;
 			reg = <0>;
 			d-cache-line-size = <32>;
diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
index daa962d..5fa309e 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
@@ -22,7 +22,7 @@
 		#size-cells = <0>;
 
 		cpu at 0 {
-			compatible = "arm,1176jz-s";
+			compatible = "arm,arm1176;
 			cpu-clock = <&arm_clk>, "cpu";
 			reg = <0>;
 			d-cache-line-size = <32>;
-- 
1.7.12
