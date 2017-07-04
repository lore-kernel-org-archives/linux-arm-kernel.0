From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  4 Jul 2017 17:15:05 +0800
Subject: [PATCH] arm64: dts: zte: remove num-slots from zx296718
Message-ID: <1499159705-66870-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/zte/zx296718.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index d83bf78..b6e369d 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -311,7 +311,6 @@
 			clock-frequency = <50000000>;
 			clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
 			clock-names = "biu", "ciu";
-			num-slots = <1>;
 			max-frequency = <50000000>;
 			cap-sdio-irq;
 			cap-sd-highspeed;
@@ -336,7 +335,6 @@
 			clock-frequency = <167000000>;
 			clocks = <&topcrm SD1_AHB>, <&topcrm SD1_WCLK>;
 			clock-names = "biu", "ciu";
-			num-slots = <1>;
 			max-frequency = <167000000>;
 			cap-sdio-irq;
 			cap-sd-highspeed;
-- 
1.9.1
