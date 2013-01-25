From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Jan 2013 09:54:06 +0100
Subject: [PATCH 2/3] ARM: dts: mxs: Add muxing options for the third PWM
In-Reply-To: <1359104048-26823-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359104048-26823-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359104048-26823-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 13b7053..7ba4966 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -502,6 +502,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				pwm3_pins_b: pwm3 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x3141 /* MX28_PAD_SAIF0_MCLK__PWM3 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				pwm4_pins_a: pwm4 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.10.4
