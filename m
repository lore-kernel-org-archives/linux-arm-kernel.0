From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Nov 2016 09:32:42 +0100
Subject: [PATCH] ARM: zynq: Fix pmu register description coding style
Message-ID: <995966ccde55b52646b929a98180d68322cb6bea.1479285154.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the space before/after '<' and '>'; and
separate the entries to be a bit more readable.

Reported-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 402b5bbe3b5b..f3ac9bfe580e 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -46,7 +46,8 @@
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 5 4>, <0 6 4>;
 		interrupt-parent = <&intc>;
-		reg = < 0xf8891000 0x1000 0xf8893000 0x1000 >;
+		reg = <0xf8891000 0x1000>,
+		      <0xf8893000 0x1000>;
 	};
 
 	regulator_vccpint: fixedregulator {
-- 
1.9.1
