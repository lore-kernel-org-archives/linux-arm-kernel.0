From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:50 +0200
Subject: [PATCH 1/6] ARM: dts: rockchip: remove rockchip,
 bus-index from rk3xxx i2c0
In-Reply-To: <1410374815-20208-1-git-send-email-heiko@sntech.de>
References: <1410374815-20208-1-git-send-email-heiko@sntech.de>
Message-ID: <1410374815-20208-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a remnant from the first i2c driver iteration that seems to have
been forgotten and thus made its way into the dtsi. Remove it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index cce4a07..c021df3 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -135,7 +135,6 @@
 		#size-cells = <0>;
 
 		rockchip,grf = <&grf>;
-		rockchip,bus-index = <0>;
 
 		clock-names = "i2c";
 		clocks = <&cru PCLK_I2C0>;
-- 
2.0.1
