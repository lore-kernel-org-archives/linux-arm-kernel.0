From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:13 +0400
Subject: [PATCH 8/8] ARM: dts: imx27-phytec-phycore-*: Move "iomux" node to
 the bottom of file
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-8-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves "iomux" node to the bottom of file.
No functional changes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 234 ++++++++++++------------
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 176 +++++++++---------
 2 files changed, 205 insertions(+), 205 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index d0b693f..07de457 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -95,123 +95,6 @@
 	};
 };
 
-&iomuxc {
-	imx27_phycore_rdk {
-		pinctrl_csien: csiengrp {
-			fsl,pins = <
-				MX27_PAD_USB_OC_B__GPIO2_24 0x0
-			>;
-		};
-
-		pinctrl_cspi1cs1: cspi1cs1grp {
-			fsl,pins = <
-				MX27_PAD_CSPI1_SS1__GPIO4_27 0x0
-			>;
-		};
-
-		pinctrl_imxfb1: imxfbgrp {
-			fsl,pins = <
-				MX27_PAD_LD0__LD0 0x0
-				MX27_PAD_LD1__LD1 0x0
-				MX27_PAD_LD2__LD2 0x0
-				MX27_PAD_LD3__LD3 0x0
-				MX27_PAD_LD4__LD4 0x0
-				MX27_PAD_LD5__LD5 0x0
-				MX27_PAD_LD6__LD6 0x0
-				MX27_PAD_LD7__LD7 0x0
-				MX27_PAD_LD8__LD8 0x0
-				MX27_PAD_LD9__LD9 0x0
-				MX27_PAD_LD10__LD10 0x0
-				MX27_PAD_LD11__LD11 0x0
-				MX27_PAD_LD12__LD12 0x0
-				MX27_PAD_LD13__LD13 0x0
-				MX27_PAD_LD14__LD14 0x0
-				MX27_PAD_LD15__LD15 0x0
-				MX27_PAD_LD16__LD16 0x0
-				MX27_PAD_LD17__LD17 0x0
-				MX27_PAD_CLS__CLS 0x0
-				MX27_PAD_CONTRAST__CONTRAST 0x0
-				MX27_PAD_LSCLK__LSCLK 0x0
-				MX27_PAD_OE_ACD__OE_ACD 0x0
-				MX27_PAD_PS__PS 0x0
-				MX27_PAD_REV__REV 0x0
-				MX27_PAD_SPL_SPR__SPL_SPR 0x0
-				MX27_PAD_HSYNC__HSYNC 0x0
-				MX27_PAD_VSYNC__VSYNC 0x0
-			>;
-		};
-
-		pinctrl_i2c1: i2c1grp {
-			/* Add pullup to DATA line */
-			fsl,pins = <
-				MX27_PAD_I2C_DATA__I2C_DATA	0x1
-				MX27_PAD_I2C_CLK__I2C_CLK	0x0
-			>;
-		};
-
-		pinctrl_owire1: owire1grp {
-			fsl,pins = <
-				MX27_PAD_RTCK__OWIRE 0x0
-			>;
-		};
-
-		pinctrl_sdhc2: sdhc2grp {
-			fsl,pins = <
-				MX27_PAD_SD2_CLK__SD2_CLK 0x0
-				MX27_PAD_SD2_CMD__SD2_CMD 0x0
-				MX27_PAD_SD2_D0__SD2_D0 0x0
-				MX27_PAD_SD2_D1__SD2_D1 0x0
-				MX27_PAD_SD2_D2__SD2_D2 0x0
-				MX27_PAD_SD2_D3__SD2_D3 0x0
-				MX27_PAD_SSI3_FS__GPIO3_28	0x0 /* WP */
-				MX27_PAD_SSI3_RXDAT__GPIO3_29	0x0 /* CD */
-			>;
-		};
-
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX27_PAD_UART1_TXD__UART1_TXD 0x0
-				MX27_PAD_UART1_RXD__UART1_RXD 0x0
-				MX27_PAD_UART1_CTS__UART1_CTS 0x0
-				MX27_PAD_UART1_RTS__UART1_RTS 0x0
-			>;
-		};
-
-		pinctrl_uart2: uart2grp {
-			fsl,pins = <
-				MX27_PAD_UART2_TXD__UART2_TXD 0x0
-				MX27_PAD_UART2_RXD__UART2_RXD 0x0
-				MX27_PAD_UART2_CTS__UART2_CTS 0x0
-				MX27_PAD_UART2_RTS__UART2_RTS 0x0
-			>;
-		};
-
-		pinctrl_usbh2: usbh2grp {
-			fsl,pins = <
-				MX27_PAD_USBH2_CLK__USBH2_CLK 0x0
-				MX27_PAD_USBH2_DIR__USBH2_DIR 0x0
-				MX27_PAD_USBH2_NXT__USBH2_NXT 0x0
-				MX27_PAD_USBH2_STP__USBH2_STP 0x0
-				MX27_PAD_CSPI2_SCLK__USBH2_DATA0 0x0
-				MX27_PAD_CSPI2_MOSI__USBH2_DATA1 0x0
-				MX27_PAD_CSPI2_MISO__USBH2_DATA2 0x0
-				MX27_PAD_CSPI2_SS1__USBH2_DATA3 0x0
-				MX27_PAD_CSPI2_SS2__USBH2_DATA4 0x0
-				MX27_PAD_CSPI1_SS2__USBH2_DATA5 0x0
-				MX27_PAD_CSPI2_SS0__USBH2_DATA6 0x0
-				MX27_PAD_USBH2_DATA7__USBH2_DATA7 0x0
-			>;
-		};
-
-		pinctrl_weim: weimgrp {
-			fsl,pins = <
-				MX27_PAD_CS4_B__CS4_B		0x0 /* CS4 */
-				MX27_PAD_SD1_D1__GPIO5_19	0x0 /* CAN IRQ */
-			>;
-		};
-	};
-};
-
 &owire {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_owire1>;
@@ -318,3 +201,120 @@
 		fsl,weim-cs-timing = <0x0000dcf6 0x444a0301 0x44443302>;
 	};
 };
+
+&iomuxc {
+	imx27_phycore_rdk {
+		pinctrl_csien: csiengrp {
+			fsl,pins = <
+				MX27_PAD_USB_OC_B__GPIO2_24		0x0
+			>;
+		};
+
+		pinctrl_cspi1cs1: cspi1cs1grp {
+			fsl,pins = <
+				MX27_PAD_CSPI1_SS1__GPIO4_27		0x0
+			>;
+		};
+
+		pinctrl_imxfb1: imxfbgrp {
+			fsl,pins = <
+				MX27_PAD_LD0__LD0			0x0
+				MX27_PAD_LD1__LD1			0x0
+				MX27_PAD_LD2__LD2			0x0
+				MX27_PAD_LD3__LD3			0x0
+				MX27_PAD_LD4__LD4			0x0
+				MX27_PAD_LD5__LD5			0x0
+				MX27_PAD_LD6__LD6			0x0
+				MX27_PAD_LD7__LD7			0x0
+				MX27_PAD_LD8__LD8			0x0
+				MX27_PAD_LD9__LD9			0x0
+				MX27_PAD_LD10__LD10			0x0
+				MX27_PAD_LD11__LD11			0x0
+				MX27_PAD_LD12__LD12			0x0
+				MX27_PAD_LD13__LD13			0x0
+				MX27_PAD_LD14__LD14			0x0
+				MX27_PAD_LD15__LD15			0x0
+				MX27_PAD_LD16__LD16			0x0
+				MX27_PAD_LD17__LD17			0x0
+				MX27_PAD_CLS__CLS			0x0
+				MX27_PAD_CONTRAST__CONTRAST		0x0
+				MX27_PAD_LSCLK__LSCLK			0x0
+				MX27_PAD_OE_ACD__OE_ACD			0x0
+				MX27_PAD_PS__PS				0x0
+				MX27_PAD_REV__REV			0x0
+				MX27_PAD_SPL_SPR__SPL_SPR		0x0
+				MX27_PAD_HSYNC__HSYNC			0x0
+				MX27_PAD_VSYNC__VSYNC			0x0
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			/* Use pullup for DATA line */
+			fsl,pins = <
+				MX27_PAD_I2C_DATA__I2C_DATA		0x1
+				MX27_PAD_I2C_CLK__I2C_CLK		0x0
+			>;
+		};
+
+		pinctrl_owire1: owire1grp {
+			fsl,pins = <
+				MX27_PAD_RTCK__OWIRE			0x0
+			>;
+		};
+
+		pinctrl_sdhc2: sdhc2grp {
+			fsl,pins = <
+				MX27_PAD_SD2_CLK__SD2_CLK		0x0
+				MX27_PAD_SD2_CMD__SD2_CMD		0x0
+				MX27_PAD_SD2_D0__SD2_D0			0x0
+				MX27_PAD_SD2_D1__SD2_D1			0x0
+				MX27_PAD_SD2_D2__SD2_D2			0x0
+				MX27_PAD_SD2_D3__SD2_D3			0x0
+				MX27_PAD_SSI3_FS__GPIO3_28		0x0 /* WP */
+				MX27_PAD_SSI3_RXDAT__GPIO3_29		0x0 /* CD */
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX27_PAD_UART1_TXD__UART1_TXD		0x0
+				MX27_PAD_UART1_RXD__UART1_RXD		0x0
+				MX27_PAD_UART1_CTS__UART1_CTS		0x0
+				MX27_PAD_UART1_RTS__UART1_RTS		0x0
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX27_PAD_UART2_TXD__UART2_TXD		0x0
+				MX27_PAD_UART2_RXD__UART2_RXD		0x0
+				MX27_PAD_UART2_CTS__UART2_CTS		0x0
+				MX27_PAD_UART2_RTS__UART2_RTS		0x0
+			>;
+		};
+
+		pinctrl_usbh2: usbh2grp {
+			fsl,pins = <
+				MX27_PAD_USBH2_CLK__USBH2_CLK		0x0
+				MX27_PAD_USBH2_DIR__USBH2_DIR		0x0
+				MX27_PAD_USBH2_NXT__USBH2_NXT		0x0
+				MX27_PAD_USBH2_STP__USBH2_STP		0x0
+				MX27_PAD_CSPI2_SCLK__USBH2_DATA0	0x0
+				MX27_PAD_CSPI2_MOSI__USBH2_DATA1	0x0
+				MX27_PAD_CSPI2_MISO__USBH2_DATA2	0x0
+				MX27_PAD_CSPI2_SS1__USBH2_DATA3		0x0
+				MX27_PAD_CSPI2_SS2__USBH2_DATA4		0x0
+				MX27_PAD_CSPI1_SS2__USBH2_DATA5		0x0
+				MX27_PAD_CSPI2_SS0__USBH2_DATA6		0x0
+				MX27_PAD_USBH2_DATA7__USBH2_DATA7	0x0
+			>;
+		};
+
+		pinctrl_weim: weimgrp {
+			fsl,pins = <
+				MX27_PAD_CS4_B__CS4_B			0x0 /* CS4 */
+				MX27_PAD_SD1_D1__GPIO5_19		0x0 /* CAN IRQ */
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 31e9f70..1509f00 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -210,94 +210,6 @@
 	};
 };
 
-&iomuxc {
-	imx27_phycore_som {
-		pinctrl_cspi1: cspi1grp {
-			fsl,pins = <
-				MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0
-				MX27_PAD_CSPI1_MOSI__CSPI1_MOSI 0x0
-				MX27_PAD_CSPI1_SCLK__CSPI1_SCLK 0x0
-				MX27_PAD_CSPI1_SS0__GPIO4_28	0x0 /* SPI1 CS0 */
-			>;
-		};
-
-		pinctrl_fec1: fec1grp {
-			fsl,pins = <
-				MX27_PAD_SD3_CMD__FEC_TXD0 0x0
-				MX27_PAD_SD3_CLK__FEC_TXD1 0x0
-				MX27_PAD_ATA_DATA0__FEC_TXD2 0x0
-				MX27_PAD_ATA_DATA1__FEC_TXD3 0x0
-				MX27_PAD_ATA_DATA2__FEC_RX_ER 0x0
-				MX27_PAD_ATA_DATA3__FEC_RXD1 0x0
-				MX27_PAD_ATA_DATA4__FEC_RXD2 0x0
-				MX27_PAD_ATA_DATA5__FEC_RXD3 0x0
-				MX27_PAD_ATA_DATA6__FEC_MDIO 0x0
-				MX27_PAD_ATA_DATA7__FEC_MDC 0x0
-				MX27_PAD_ATA_DATA8__FEC_CRS 0x0
-				MX27_PAD_ATA_DATA9__FEC_TX_CLK 0x0
-				MX27_PAD_ATA_DATA10__FEC_RXD0 0x0
-				MX27_PAD_ATA_DATA11__FEC_RX_DV 0x0
-				MX27_PAD_ATA_DATA12__FEC_RX_CLK 0x0
-				MX27_PAD_ATA_DATA13__FEC_COL 0x0
-				MX27_PAD_ATA_DATA14__FEC_TX_ER 0x0
-				MX27_PAD_ATA_DATA15__FEC_TX_EN 0x0
-				MX27_PAD_SSI3_TXDAT__GPIO3_30	0x0 /* FEC RST */
-			>;
-		};
-
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX27_PAD_I2C2_SDA__I2C2_SDA 0x0
-				MX27_PAD_I2C2_SCL__I2C2_SCL 0x0
-			>;
-		};
-
-		pinctrl_nfc: nfcgrp {
-			fsl,pins = <
-				MX27_PAD_NFRB__NFRB 0x0
-				MX27_PAD_NFCLE__NFCLE 0x0
-				MX27_PAD_NFWP_B__NFWP_B 0x0
-				MX27_PAD_NFCE_B__NFCE_B 0x0
-				MX27_PAD_NFALE__NFALE 0x0
-				MX27_PAD_NFRE_B__NFRE_B 0x0
-				MX27_PAD_NFWE_B__NFWE_B 0x0
-			>;
-		};
-
-		pinctrl_pmic: pmicgrp {
-			fsl,pins = <
-				MX27_PAD_USB_PWR__GPIO2_23	0x0 /* PMIC IRQ */
-			>;
-		};
-
-		pinctrl_ssi1: ssi1grp {
-			fsl,pins = <
-				MX27_PAD_SSI1_FS__SSI1_FS 0x0
-				MX27_PAD_SSI1_RXDAT__SSI1_RXDAT 0x0
-				MX27_PAD_SSI1_TXDAT__SSI1_TXDAT 0x0
-				MX27_PAD_SSI1_CLK__SSI1_CLK 0x0
-			>;
-		};
-
-		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <
-				MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
-				MX27_PAD_USBOTG_DIR__USBOTG_DIR 0x0
-				MX27_PAD_USBOTG_NXT__USBOTG_NXT 0x0
-				MX27_PAD_USBOTG_STP__USBOTG_STP 0x0
-				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0 0x0
-				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1 0x0
-				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2 0x0
-				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3 0x0
-				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4 0x0
-				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5 0x0
-				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6 0x0
-				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
-			>;
-		};
-	};
-};
-
 &nfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nfc>;
@@ -348,3 +260,91 @@
 		#size-cells = <1>;
 	};
 };
+
+&iomuxc {
+	imx27_phycore_som {
+		pinctrl_cspi1: cspi1grp {
+			fsl,pins = <
+				MX27_PAD_CSPI1_MISO__CSPI1_MISO		0x0
+				MX27_PAD_CSPI1_MOSI__CSPI1_MOSI		0x0
+				MX27_PAD_CSPI1_SCLK__CSPI1_SCLK		0x0
+				MX27_PAD_CSPI1_SS0__GPIO4_28		0x0 /* SPI1 CS0 */
+			>;
+		};
+
+		pinctrl_fec1: fec1grp {
+			fsl,pins = <
+				MX27_PAD_SD3_CMD__FEC_TXD0		0x0
+				MX27_PAD_SD3_CLK__FEC_TXD1		0x0
+				MX27_PAD_ATA_DATA0__FEC_TXD2		0x0
+				MX27_PAD_ATA_DATA1__FEC_TXD3		0x0
+				MX27_PAD_ATA_DATA2__FEC_RX_ER		0x0
+				MX27_PAD_ATA_DATA3__FEC_RXD1		0x0
+				MX27_PAD_ATA_DATA4__FEC_RXD2		0x0
+				MX27_PAD_ATA_DATA5__FEC_RXD3		0x0
+				MX27_PAD_ATA_DATA6__FEC_MDIO		0x0
+				MX27_PAD_ATA_DATA7__FEC_MDC		0x0
+				MX27_PAD_ATA_DATA8__FEC_CRS		0x0
+				MX27_PAD_ATA_DATA9__FEC_TX_CLK		0x0
+				MX27_PAD_ATA_DATA10__FEC_RXD0		0x0
+				MX27_PAD_ATA_DATA11__FEC_RX_DV		0x0
+				MX27_PAD_ATA_DATA12__FEC_RX_CLK		0x0
+				MX27_PAD_ATA_DATA13__FEC_COL		0x0
+				MX27_PAD_ATA_DATA14__FEC_TX_ER		0x0
+				MX27_PAD_ATA_DATA15__FEC_TX_EN		0x0
+				MX27_PAD_SSI3_TXDAT__GPIO3_30		0x0 /* FEC RST */
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX27_PAD_I2C2_SDA__I2C2_SDA		0x0
+				MX27_PAD_I2C2_SCL__I2C2_SCL		0x0
+			>;
+		};
+
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+				MX27_PAD_NFRB__NFRB			0x0
+				MX27_PAD_NFCLE__NFCLE			0x0
+				MX27_PAD_NFWP_B__NFWP_B			0x0
+				MX27_PAD_NFCE_B__NFCE_B			0x0
+				MX27_PAD_NFALE__NFALE			0x0
+				MX27_PAD_NFRE_B__NFRE_B			0x0
+				MX27_PAD_NFWE_B__NFWE_B			0x0
+			>;
+		};
+
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX27_PAD_USB_PWR__GPIO2_23		0x0 /* PMIC IRQ */
+			>;
+		};
+
+		pinctrl_ssi1: ssi1grp {
+			fsl,pins = <
+				MX27_PAD_SSI1_FS__SSI1_FS		0x0
+				MX27_PAD_SSI1_RXDAT__SSI1_RXDAT		0x0
+				MX27_PAD_SSI1_TXDAT__SSI1_TXDAT		0x0
+				MX27_PAD_SSI1_CLK__SSI1_CLK		0x0
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX27_PAD_USBOTG_CLK__USBOTG_CLK		0x0
+				MX27_PAD_USBOTG_DIR__USBOTG_DIR		0x0
+				MX27_PAD_USBOTG_NXT__USBOTG_NXT		0x0
+				MX27_PAD_USBOTG_STP__USBOTG_STP		0x0
+				MX27_PAD_USBOTG_DATA0__USBOTG_DATA0	0x0
+				MX27_PAD_USBOTG_DATA1__USBOTG_DATA1	0x0
+				MX27_PAD_USBOTG_DATA2__USBOTG_DATA2	0x0
+				MX27_PAD_USBOTG_DATA3__USBOTG_DATA3	0x0
+				MX27_PAD_USBOTG_DATA4__USBOTG_DATA4	0x0
+				MX27_PAD_USBOTG_DATA5__USBOTG_DATA5	0x0
+				MX27_PAD_USBOTG_DATA6__USBOTG_DATA6	0x0
+				MX27_PAD_USBOTG_DATA7__USBOTG_DATA7	0x0
+			>;
+		};
+	};
+};
-- 
1.8.3.2
