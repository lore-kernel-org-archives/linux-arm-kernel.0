From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Jan 2014 00:23:36 +0100
Subject: [PATCH] ARM: dts: mxs: Fix the RTC compatible prop on M28EVK
Message-ID: <1390519416-6760-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible property should be m41t62, not mt41t62, so fix this.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 8536b0d..f0ad7b9 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -194,7 +194,7 @@
 				};
 
 				rtc: rtc at 68 {
-					compatible = "stm,mt41t62";
+					compatible = "stm,m41t62";
 					reg = <0x68>;
 				};
 			};
-- 
1.8.5.2
