From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 10 Dec 2015 13:46:37 +0800
Subject: [PATCH 1/3] ARM: dts: rockchip: correct the name of REG8 for
 rk3288-evb-act8846
Message-ID: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the schematic, the name of REG8 should be vcc_tp, rather
than vcca_tp.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/boot/dts/rk3288-evb-act8846.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 43949a6..53d8b08 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -152,7 +152,7 @@
 				regulator-always-on;
 			};
 
-			vcca_tp: REG8 {
+			vcc_tp: REG8 {
 				regulator-name = "VCCA_TP";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-- 
2.6.3
