From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  4 Mar 2014 17:28:40 +0100
Subject: [PATCH v3 4/5] ARM: sun6i: Enable the I2C muxing options
In-Reply-To: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393950521-4173-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controllers have a few muxing options on the A31. Enable the
ones found in the A31 Colombus board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 22d3eae..8d3ea29 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -257,6 +257,27 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PH14", "PH15";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PH16", "PH17";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PH18", "PH19";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		ahb1_rst: reset at 01c202c0 {
-- 
1.9.0
