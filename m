From: julien.boibessot@free.fr (julien.boibessot at free.fr)
Date: Sat, 27 Oct 2012 12:15:46 +0200
Subject: [PATCH] ARM: dts: mxs: Add PWM3 muxing options for i.MX28
Message-ID: <1351332946-5933-1-git-send-email-julien.boibessot@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Boibessot <julien.boibessot@armadeus.com>

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 arch/arm/boot/dts/imx28.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e16d631..2b607aa 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -491,6 +491,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				pwm3_pins_a: pwm3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31c0 /* MX28_PAD_PWM3__PWM_3 */
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
1.7.5.4
