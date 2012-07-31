From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jul 2012 12:29:34 +0200
Subject: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for
 imx28
In-Reply-To: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/imx28.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 915db89..44ce1fd 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -410,6 +410,14 @@
 					fsl,pull-up = <1>;
 				};
 
+				i2c0_pins_b: i2c0 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <0x3001 0x3011>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				saif0_pins_a: saif0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5
