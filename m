From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 31 Jan 2014 15:31:06 +0200
Subject: [PATCH] ARM: dts: k2hk-evm: rename clock node to clocks
Message-ID: <1391175066-13862-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix type in clock(s) node name: "clock"-->"clocks".

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index eaefdfe..c02c3a8 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -15,7 +15,7 @@
 	compatible =  "ti,keystone-evm";
 
 	soc {
-		clock {
+		clocks {
 			refclksys: refclksys {
 				#clock-cells = <0>;
 				compatible = "fixed-clock";
-- 
1.7.9.5
