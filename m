From: hramrach@gmail.com (Michal Suchanek)
Date: 26 May 2016 19:25:22 -0000
Subject: [PATCH 1/3] ARM: dts: sun5i: a10s: add spi2 pins
Message-ID: <908ed06eb46f2162e222258aa14df545d0fa5b48.1464129859.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used on A10s Olinuxino.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index bddd0de..651837c 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -241,6 +241,20 @@
 		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	spi2_pins_a: spi2 at 0 {
+		allwinner,pins = "PB12", "PB13", "PB14";
+		allwinner,function = "spi2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	spi2_cs0_pins_a: spi2_cs0 at 0 {
+		allwinner,pins = "PB11";
+		allwinner,function = "spi2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &sram_a {
-- 
2.8.1
