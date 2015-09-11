From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 11 Sep 2015 15:24:28 +0800
Subject: [PATCH 1/2] ARM: dts: support Highspeed for rk3188-radxarock
Message-ID: <1441956268-10418-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cap-sd-highspeed and cap-mmc-highspeed for rk3188-radxarock
board to make sd cards running faster.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/boot/dts/rk3188-radxarock.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index d2180e5..2f37ea7 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -287,7 +287,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
 	vmmc-supply = <&vcc_sd0>;
-
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
 	bus-width = <4>;
 	disable-wp;
 };
-- 
2.3.7
