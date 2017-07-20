From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:00 +0200
Subject: [PATCH 01/10] arm64: zynqmp: Add references to cpu nodes
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <b9a61dfe7f5d4309b3131c1b9a82890888838087.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing references to all cpu nodes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 1a3f5e928bb9..4f7d9905e235 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -20,28 +20,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			enable-method = "psci";
 			reg = <0x0>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			enable-method = "psci";
 			reg = <0x1>;
 		};
 
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			enable-method = "psci";
 			reg = <0x2>;
 		};
 
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			enable-method = "psci";
-- 
1.9.1
