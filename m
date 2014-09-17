From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 17 Sep 2014 15:10:03 +0300
Subject: [PATCH v2 1/6] ARM: dts: sbc-t54: fix mux mode comment style
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410955808-2174-2-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the comment style of mode0_name.modeX_name for pins
which mux mode differs from MUX_MODE0.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

 v2: New patch

 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-sbc-t54.dts b/arch/arm/boot/dts/omap5-sbc-t54.dts
index 8e89793..337bbbc 100644
--- a/arch/arm/boot/dts/omap5-sbc-t54.dts
+++ b/arch/arm/boot/dts/omap5-sbc-t54.dts
@@ -19,8 +19,8 @@
 
 	mmc1_aux_pins: pinmux_mmc1_aux_pins {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x0174, PIN_INPUT_PULLUP | MUX_MODE6) /* gpio8_228 */
-			OMAP5_IOPAD(0x0176, PIN_INPUT_PULLUP | MUX_MODE6) /* gpio8_229 */
+			OMAP5_IOPAD(0x0174, PIN_INPUT_PULLUP | MUX_MODE6) /* timer5_pwm_evt.gpio8_228 */
+			OMAP5_IOPAD(0x0176, PIN_INPUT_PULLUP | MUX_MODE6) /* timer6_pwm_evt.gpio8_229 */
 		>;
 	};
 };
-- 
1.7.5.4
