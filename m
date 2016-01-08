From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri,  8 Jan 2016 19:31:38 +0800
Subject: [RESEND RFC PATCH 2/2] ARM: dts: rockchip: Update the cpu freqs table
In-Reply-To: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
References: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1452252698-16765-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually, we need more cpu freqs which are 50MHz integer multiples.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 arch/arm/boot/dts/rk3036.dtsi |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 1cb5877..1a773eb 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -79,7 +79,18 @@
 			resets = <&cru SRST_CORE0>;
 			operating-points = <
 				/* KHz    uV */
-				 816000 1000000
+				1200000 1200000
+				1100000 1200000
+				1000000 1200000
+				 900000 1200000
+				 800000 1200000
+				 700000 1200000
+				 600000 1200000
+				 500000 1200000
+				 400000 1200000
+				 300000 1200000
+				 200000 1200000
+				 100000 1200000
 			>;
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
-- 
1.7.9.5
