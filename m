From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 31 Jan 2017 15:43:13 +0300
Subject: [PATCH v6 2/5] ARM: dts: rockchip: update compatible property for
 rk322x timer
In-Reply-To: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
References: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485866596-32254-3-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property set to '"rockchip,rk3228-timer", "rockchip,rk3288-timer"'
to match devicetree bindings.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Suggested-by: Heiko St?bner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk322x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9e6bf0e..2a4eee2 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -323,7 +323,7 @@
 	};
 
 	timer: timer at 110c0000 {
-		compatible = "rockchip,rk3288-timer";
+		compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
 		reg = <0x110c0000 0x20>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-- 
1.7.9.5
