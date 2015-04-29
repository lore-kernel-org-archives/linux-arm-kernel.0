From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Apr 2015 10:02:07 +0200
Subject: [PATCH 2/4] ARM: dts: sunxi: sun5i-a10s: add spi2_pins_a.
In-Reply-To: <cover.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
Message-ID: <bde22eb1696fd4d61546eb63af5685c3fa27d453.1430295711.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extra SPI pins on A10s not shared with A13.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index a78c95d..3cdd122 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -198,4 +198,12 @@
 		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	spi2_pins_a: spi2 at 0 {
+		allwinner,pins = "PB11", "PB12", "PB13", "PB14";
+		allwinner,function = "spi2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 };
-- 
2.1.4
