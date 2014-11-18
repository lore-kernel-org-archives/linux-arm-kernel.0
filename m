From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 18 Nov 2014 11:13:16 +0200
Subject: [PATCH 1/9] ARM: dts: cm-t3x: cleanup comments indentation
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416302004-22199-2-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix comment style

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index b074673..e4c0c56 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -107,12 +107,12 @@
 
 	dss_dpi_pins_cm_t35x: pinmux_dss_dpi_pins_cm_t35x {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)		/* dss_data0.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)		/* dss_data1.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)		/* dss_data2.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)		/* dss_data3.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)		/* dss_data4.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)		/* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)	/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)	/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)	/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)	/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)	/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
 		>;
 	};
 };
-- 
1.7.5.4
