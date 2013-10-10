From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 10 Oct 2013 10:10:18 -0700
Subject: [PATCH v2 2/2] arm: dt: zynq: Add fclk-enable property to clkc node
In-Reply-To: <1381425018-5653-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1381425018-5653-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1381425018-5653-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
This is kind of optional since it does not have any effect due to the changed
default in 1/2.

v2:
 - no change


 arch/arm/boot/dts/zynq-7000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e32b92b949d2..b48d0403537b 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -77,6 +77,7 @@
 					#clock-cells = <1>;
 					compatible = "xlnx,ps7-clkc";
 					ps-clk-frequency = <33333333>;
+					fclk-enable = <0>;
 					clock-output-names = "armpll", "ddrpll", "iopll", "cpu_6or4x",
 							"cpu_3or2x", "cpu_2x", "cpu_1x", "ddr2x", "ddr3x",
 							"dci", "lqspi", "smc", "pcap", "gem0", "gem1",
-- 
1.8.4
