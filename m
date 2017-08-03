From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu,  3 Aug 2017 15:02:00 +0800
Subject: [PATCH] arm64: dts: rockchip: include opp dtsi for rk3399 firefly
Message-ID: <1501743720-6778-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add opp tables for cpu cluster0 and cluster1 by including
rk3399-opp.dtsi.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index eed7e99..7fd4bfc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -43,6 +43,7 @@
 /dts-v1/;
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
 
 / {
 	model = "Firefly-RK3399 Board";
-- 
1.9.1
