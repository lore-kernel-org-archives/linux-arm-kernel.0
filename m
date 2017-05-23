From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 11:54:26 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: add ethernet alias on rk3399
In-Reply-To: <20170523095427.7421-1-heiko@sntech.de>
References: <20170523095427.7421-1-heiko@sntech.de>
Message-ID: <20170523095427.7421-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used by bootloaders to override the mac address in the devicetree
if needed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index db713c67ae17..3e1b1daa0964 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -56,6 +56,7 @@
 	#size-cells = <2>;
 
 	aliases {
+		ethernet = &gmac;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.11.0
