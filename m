From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 26 Sep 2018 13:39:39 +0200
Subject: [PATCH] arm64: dts: Use mmc@ instead sdhci@
Message-ID: <59fd089c075740303d81e4a3475598dfd48e5026.1537961975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc name is recommended based on devicetree specification.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce23422acf..dacabde6ff7e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -484,7 +484,7 @@
 			interrupts = <0 133 4>;
 		};
 
-		sdhci0: sdhci at ff160000 {
+		sdhci0: mmc at ff160000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -493,7 +493,7 @@
 			clock-names = "clk_xin", "clk_ahb";
 		};
 
-		sdhci1: sdhci at ff170000 {
+		sdhci1: mmc at ff170000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-- 
1.9.1
