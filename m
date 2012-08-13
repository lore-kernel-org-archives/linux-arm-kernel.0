From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:21 +0800
Subject: [PATCH 01/17] ARM: dts: imx6q: improve indentation for fsl,pins
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the indentation for property fsl,pins a little bit, so that
the first and the last line get the same indentation with all other
lines.  Then it will be easier to copy and past any of these lines.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    6 +-
 arch/arm/boot/dts/imx6q.dtsi          |  114 ++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d42e851..ee5de8f 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -51,9 +51,9 @@
 				gpios {
 					pinctrl_gpio_hog: gpiohog {
 						fsl,pins = <
-							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
-							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
-							   >;
+							144 0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
+							121 0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
+						>;
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 28b6a62..bd72a4f 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -506,86 +506,100 @@
 				/* shared pinctrl settings */
 				audmux {
 					pinctrl_audmux_1: audmux-1 {
-						fsl,pins = <18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
-							    1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
-							    11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
-							    3    0x80000000>;	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
+						fsl,pins = <
+							18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
+							1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
+							11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
+							3    0x80000000	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
+						>;
 					};
 				};
 
 				gpmi-nand {
 					pinctrl_gpmi_nand_1: gpmi-nand-1 {
-						fsl,pins = <1328 0xb0b1		/* MX6Q_PAD_NANDF_CLE__RAWNAND_CLE */
-							    1336 0xb0b1		/* MX6Q_PAD_NANDF_ALE__RAWNAND_ALE */
-							    1344 0xb0b1		/* MX6Q_PAD_NANDF_WP_B__RAWNAND_RESETN */
-							    1352 0xb000		/* MX6Q_PAD_NANDF_RB0__RAWNAND_READY0 */
-							    1360 0xb0b1		/* MX6Q_PAD_NANDF_CS0__RAWNAND_CE0N */
-							    1365 0xb0b1		/* MX6Q_PAD_NANDF_CS1__RAWNAND_CE1N */
-							    1371 0xb0b1		/* MX6Q_PAD_NANDF_CS2__RAWNAND_CE2N */
-							    1378 0xb0b1		/* MX6Q_PAD_NANDF_CS3__RAWNAND_CE3N */
-							    1387 0xb0b1		/* MX6Q_PAD_SD4_CMD__RAWNAND_RDN */
-							    1393 0xb0b1		/* MX6Q_PAD_SD4_CLK__RAWNAND_WRN */
-							    1397 0xb0b1		/* MX6Q_PAD_NANDF_D0__RAWNAND_D0 */
-							    1405 0xb0b1		/* MX6Q_PAD_NANDF_D1__RAWNAND_D1 */
-							    1413 0xb0b1		/* MX6Q_PAD_NANDF_D2__RAWNAND_D2 */
-							    1421 0xb0b1		/* MX6Q_PAD_NANDF_D3__RAWNAND_D3 */
-							    1429 0xb0b1		/* MX6Q_PAD_NANDF_D4__RAWNAND_D4 */
-							    1437 0xb0b1		/* MX6Q_PAD_NANDF_D5__RAWNAND_D5 */
-							    1445 0xb0b1		/* MX6Q_PAD_NANDF_D6__RAWNAND_D6 */
-							    1453 0xb0b1		/* MX6Q_PAD_NANDF_D7__RAWNAND_D7 */
-							    1463 0x00b1>;	/* MX6Q_PAD_SD4_DAT0__RAWNAND_DQS */
+						fsl,pins = <
+							1328 0xb0b1	/* MX6Q_PAD_NANDF_CLE__RAWNAND_CLE */
+							1336 0xb0b1	/* MX6Q_PAD_NANDF_ALE__RAWNAND_ALE */
+							1344 0xb0b1	/* MX6Q_PAD_NANDF_WP_B__RAWNAND_RESETN */
+							1352 0xb000	/* MX6Q_PAD_NANDF_RB0__RAWNAND_READY0 */
+							1360 0xb0b1	/* MX6Q_PAD_NANDF_CS0__RAWNAND_CE0N */
+							1365 0xb0b1	/* MX6Q_PAD_NANDF_CS1__RAWNAND_CE1N */
+							1371 0xb0b1	/* MX6Q_PAD_NANDF_CS2__RAWNAND_CE2N */
+							1378 0xb0b1	/* MX6Q_PAD_NANDF_CS3__RAWNAND_CE3N */
+							1387 0xb0b1	/* MX6Q_PAD_SD4_CMD__RAWNAND_RDN */
+							1393 0xb0b1	/* MX6Q_PAD_SD4_CLK__RAWNAND_WRN */
+							1397 0xb0b1	/* MX6Q_PAD_NANDF_D0__RAWNAND_D0 */
+							1405 0xb0b1	/* MX6Q_PAD_NANDF_D1__RAWNAND_D1 */
+							1413 0xb0b1	/* MX6Q_PAD_NANDF_D2__RAWNAND_D2 */
+							1421 0xb0b1	/* MX6Q_PAD_NANDF_D3__RAWNAND_D3 */
+							1429 0xb0b1	/* MX6Q_PAD_NANDF_D4__RAWNAND_D4 */
+							1437 0xb0b1	/* MX6Q_PAD_NANDF_D5__RAWNAND_D5 */
+							1445 0xb0b1	/* MX6Q_PAD_NANDF_D6__RAWNAND_D6 */
+							1453 0xb0b1	/* MX6Q_PAD_NANDF_D7__RAWNAND_D7 */
+							1463 0x00b1	/* MX6Q_PAD_SD4_DAT0__RAWNAND_DQS */
+						>;
 					};
 				};
 
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
-						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
-							    196 0x4001b8b1>;	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
+						fsl,pins = <
+							137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
+							196 0x4001b8b1	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
+						>;
 					};
 				};
 
 				serial2 {
 					pinctrl_serial2_1: serial2grp-1 {
-						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
-							    191 0x1b0b1>;	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+						fsl,pins = <
+							183 0x1b0b1	/* MX6Q_PAD_EIM_D26__UART2_TXD */
+							191 0x1b0b1	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+						>;
 					};
 				};
 
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
-						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-							    1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
-							    1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
-							    1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
-							    1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
-							    1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
-							    1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
-							    1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
-							    1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
-							    1241 0x17059>;	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
+						fsl,pins = <
+							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+							1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
+							1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
+							1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
+							1241 0x17059	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
+						>;
 					};
 				};
 
 				usdhc4 {
 					pinctrl_usdhc4_1: usdhc4grp-1 {
-						fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
-							    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-							    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-							    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-							    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-							    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-							    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
-							    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
-							    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
-							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+						fsl,pins = <
+							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+							1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
+							1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
+							1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
+							1517 0x17059	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+						>;
 					};
 				};
 
 				ecspi1 {
 					pinctrl_ecspi1_1: ecspi1grp-1 {
-						fsl,pins = <101 0x100b1		/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
-							    109 0x100b1		/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
-							    94  0x100b1>;	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
+						fsl,pins = <
+							101 0x100b1	/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
+							109 0x100b1	/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
+							94  0x100b1	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
+						>;
 					};
 				};
 			};
-- 
1.7.5.4
