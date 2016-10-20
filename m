From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 20 Oct 2016 21:15:27 +0200
Subject: [PATCH] ARM: dts: armada-370-rn102: drop specification of compatible
 for i2c0
Message-ID: <20161020191527.27679-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string is already provided by armada-370.dtsi.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is the same as commit 43940ce3b089962f97de544d72b783bd146ef362 that
currently is in next, just for rn102 instead of rn104.

Best regards
Uwe

 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 39181b3fa90d..3ca6330a1752 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -120,7 +120,6 @@
 			};
 
 			i2c at 11000 {
-				compatible = "marvell,mv64xxx-i2c";
 				clock-frequency = <100000>;
 				status = "okay";
 
-- 
2.9.3
