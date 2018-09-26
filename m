From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 26 Sep 2018 13:38:07 +0200
Subject: [PATCH] ARM: dts: Use mmc@ instead sdhci@
Message-ID: <84c0bf4f601d9bb30d8caeafa7df3c081009c971.1537961882.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc name is recommended based on devicetree specification.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e22507e23303..ca6425ad794c 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -219,7 +219,7 @@
 			#size-cells = <0>;
 		};
 
-		sdhci0: sdhci at e0100000 {
+		sdhci0: mmc at e0100000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
@@ -229,7 +229,7 @@
 			reg = <0xe0100000 0x1000>;
 		};
 
-		sdhci1: sdhci at e0101000 {
+		sdhci1: mmc at e0101000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
-- 
1.9.1
