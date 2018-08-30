From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 30 Aug 2018 13:20:05 +0800
Subject: [PATCH] ARM: dts: imx6ull: update iomux header
Message-ID: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update i.MX6ULL iomux header according to latest reference
manual Rev.1, 11/2017.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index 3c12a6f..a282a31 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -27,10 +27,25 @@
 #define MX6UL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
 
 /* signals for i.MX6ULL only */
+#define MX6ULL_PAD_UART1_TX_DATA__UART5_DCE_TX                    0x0084 0x0310 0x0000 0x9 0x0
 #define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
 #define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
-#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
-#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
+#define MX6ULL_PAD_UART1_RX_DATA__UART5_DTE_TX                    0x0088 0x0314 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_CTS                     0x008C 0x0318 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART1_CTS_B__UART5_DTE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
+#define MX6ULL_PAD_UART1_RTS_B__UART5_DCE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
+#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_CTS                     0x0090 0x031C 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART4_RX_DATA__EPDC_PWRCTRL01                  0x00B8 0x0344 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_TX_DATA__EPDC_PWRCTRL02                  0x00BC 0x0348 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_RX_DATA__EPDC_PWRCTRL03                  0x00C0 0x034C 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_DATA0__EPDC_SDCE04                    0x00C4 0x0350 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_DATA1__EPDC_SDCE05                    0x00C8 0x0354 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_EN__EPDC_SDCE06                       0x00CC 0x0358 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_DATA0__EPDC_SDCE07                    0x00D0 0x035C 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_DATA1__EPDC_SDCE08                    0x00D4 0x0360 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_EN__EPDC_SDCE09                       0x00D8 0x0364 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_CLK__EPDC_SDOED                       0x00DC 0x0368 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_ER__EPDC_SDOEZ                        0x00E0 0x036C 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
@@ -57,6 +72,8 @@
 #define MX6ULL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158 0x03E4 0x0000 0x9 0x0
 #define MX6ULL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C 0x03E8 0x0000 0x9 0x0
 #define MX6ULL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C 0x03F8 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA22__EPDC_SDCE02                        0x0170 0x03FC 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA23__EPDC_SDCE03                        0x0174 0x0400 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_MCLK__ESAI_TX3_RX2                         0x01D4 0x0460 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_PIXCLK__ESAI_TX2_RX3                       0x01D8 0x0464 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_VSYNC__ESAI_TX4_RX1                        0x01DC 0x0468 0x0000 0x9 0x0
-- 
2.7.4
