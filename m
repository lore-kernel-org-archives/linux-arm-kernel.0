From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 30 Jun 2014 09:56:36 -0700
Subject: [PATCH 4/4] ARM: zynq: dt: Use properly rounded frequencies in OPPs
In-Reply-To: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1404147396-8041-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the clk_find_nearest_rate() API, OPPs can be specified
using proper rounding, now.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

---
 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 760bbc463c5b..b8e39ed5b132 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -29,8 +29,8 @@
 			operating-points = <
 				/* kHz    uV */
 				666667  1000000
-				333334  1000000
-				222223  1000000
+				333333  1000000
+				222222  1000000
 			>;
 		};
 
-- 
2.0.1.1.gfbfc394
