From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 7 Jan 2014 09:43:15 -0600
Subject: [PATCH] dts: socfpga: update L2 tag and data latency
Message-ID: <1389109395-29530-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Sets the appropriate L2-cache latencies for the SOCFPGA platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 433bfbc..d04dd82 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -468,6 +468,8 @@
 			interrupts = <0 38 0x04>;
 			cache-unified;
 			cache-level = <2>;
+			arm,tag-latency = <1 1 1>;
+			arm,data-latency = <2 1 1>;
 		};
 
 		mmc: dwmmc0 at ff704000 {
-- 
1.7.9.5
