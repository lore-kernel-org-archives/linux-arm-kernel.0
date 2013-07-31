From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 31 Jul 2013 16:24:59 -0700
Subject: [PATCH] arm: zynq: dt: Set correct L2 ram latencies
Message-ID: <1375313099-8402-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 6f54a64..e32b92b 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -41,8 +41,8 @@
 		L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xF8F02000 0x1000>;
-			arm,data-latency = <2 3 2>;
-			arm,tag-latency = <2 3 2>;
+			arm,data-latency = <3 2 2>;
+			arm,tag-latency = <2 2 2>;
 			cache-unified;
 			cache-level = <2>;
 		};
-- 
1.8.3.4
