From: michal.simek@xilinx.com (Michal Simek)
Date: Tue,  9 Aug 2016 15:38:17 +0200
Subject: [PATCH 2/2] ARM64: zynqmp: Correct the watchdog timer interrupt number
In-Reply-To: <73e2ff39077d4593e92a1b484fbb586afcddb4bf.1470749892.git.michal.simek@xilinx.com>
References: <73e2ff39077d4593e92a1b484fbb586afcddb4bf.1470749892.git.michal.simek@xilinx.com>
Message-ID: <1d73c4f687ebab2f5f2c48f9174055f08bdd40dd.1470749892.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>

Corrected the watchdog timer interrupt number.
Origin value was for CSUPMU watchdog.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 8ed4f42e781b..3bae4b2675d9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -369,7 +369,7 @@
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-			interrupts = <0 52 1>;
+			interrupts = <0 113 1>;
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
-- 
1.9.1
