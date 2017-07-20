From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:07 +0200
Subject: [PATCH 08/10] arm64: zynqmp: Correct IRQ nr for the SMMU
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <a0034f0263d59aaba385092318ddf7dd5ccbe8db.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 1272fa6d4f99..4adf5285f56d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -341,11 +341,11 @@
 			reg = <0x0 0xfd800000 0x0 0x20000>;
 			#global-interrupts = <1>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 157 4>,
-				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
-				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
-				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>,
-				<0 157 4>, <0 157 4>, <0 157 4>, <0 157 4>;
+			interrupts = <0 155 4>,
+				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
+				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
+				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>,
+				<0 155 4>, <0 155 4>, <0 155 4>, <0 155 4>;
 		};
 
 		spi0: spi at ff040000 {
-- 
1.9.1
