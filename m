From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 17 Sep 2014 15:10:04 +0300
Subject: [PATCH v2 2/6] ARM: dts: cm-t54: fix mux mode comment style
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410955808-2174-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the comment style of mode0_name.modeX_name for pins
which mux mode differs from MUX_MODE0.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

 v2: New patch

 arch/arm/boot/dts/omap5-cm-t54.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 429471a..44a9f23 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -127,8 +127,8 @@
 
 	wlan_gpios_pins: pinmux_wlan_gpios_pins {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x019c, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_109 */
-			OMAP5_IOPAD(0x019e, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_110 */
+			OMAP5_IOPAD(0x019c, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* abemcpdm_ul_data.gpio4_109 */
+			OMAP5_IOPAD(0x019e, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* abemcpdm_dl_data.gpio4_110 */
 		>;
 	};
 
-- 
1.7.5.4
