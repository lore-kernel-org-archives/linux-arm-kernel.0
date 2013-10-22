From: lisovy@gmail.com (Rostislav Lisovy)
Date: Tue, 22 Oct 2013 19:07:20 +0200
Subject: [PATCH 1/4] ARM: dts: i.MX53: Add alternate pinmux option for i2c_3
In-Reply-To: <1382461643-16790-1-git-send-email-lisovy@gmail.com>
References: <1382461643-16790-1-git-send-email-lisovy@gmail.com>
Message-ID: <1382461643-16790-2-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..55e83d1 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -599,6 +599,13 @@
 							MX53_PAD_GPIO_5__I2C3_SCL 0xc0000000
 						>;
 					};
+
+					pinctrl_i2c3_2: i2c3grp-2 {
+						fsl,pins = <
+							MX53_PAD_GPIO_3__I2C3_SCL	0xc0000000
+							MX53_PAD_GPIO_6__I2C3_SDA	0xc0000000
+						>;
+					};
 				};
 
 				ipu_disp0 {
-- 
1.7.10.4
