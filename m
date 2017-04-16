From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:27:13 +0200
Subject: [PATCH 23/29] ARM: dts: rockchip: Update compatible property for
 rk322x timer
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-23-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Kochetkov <al.kochet@gmail.com>

Property set to '"rockchip,rk3228-timer", "rockchip,rk3288-timer"'
to match devicetree bindings.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Suggested-by: Heiko St?bner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9dff822..641607d 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -325,7 +325,7 @@
 	};
 
 	timer: timer at 110c0000 {
-		compatible = "rockchip,rk3288-timer";
+		compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
 		reg = <0x110c0000 0x20>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-- 
2.7.4
