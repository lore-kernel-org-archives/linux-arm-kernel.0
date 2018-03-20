From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 20 Mar 2018 10:08:40 +0800
Subject: [PATCH V2] ARM: dts: imx7d-pinfunc: update sai select input value
Message-ID: <1521511720-17598-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update SAI select input daisy chain value according to
Reference Manual.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index f2493bc..aa9dbea 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -592,7 +592,7 @@
 #define MX7D_PAD_UART2_RX_DATA__UART2_DCE_RX                      0x0130 0x03A0 0x06FC 0x0 0x2
 #define MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX                      0x0130 0x03A0 0x0000 0x0 0x0
 #define MX7D_PAD_UART2_RX_DATA__I2C2_SCL                          0x0130 0x03A0 0x05DC 0x1 0x0
-#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x0000 0x2 0x0
+#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x06C4 0x2 0x0
 #define MX7D_PAD_UART2_RX_DATA__ECSPI1_SS3                        0x0130 0x03A0 0x0000 0x3 0x0
 #define MX7D_PAD_UART2_RX_DATA__ENET2_1588_EVENT1_IN              0x0130 0x03A0 0x0000 0x4 0x0
 #define MX7D_PAD_UART2_RX_DATA__GPIO4_IO2                         0x0130 0x03A0 0x0000 0x5 0x0
@@ -1112,13 +1112,13 @@
 #define MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9                       0x0250 0x04C0 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TD3__CAAM_RNG_OSC_OBS                0x0250 0x04C0 0x0000 0x7 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL           0x0254 0x04C4 0x0000 0x0 0x0
-#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x06A4 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPT2_COMPARE1                0x0254 0x04C4 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__EPDC_PWR_CTRL2               0x0254 0x04C4 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10                   0x0254 0x04C4 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC                 0x0258 0x04C8 0x0000 0x0 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_TX_ER                     0x0258 0x04C8 0x0000 0x1 0x0
-#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x069C 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TXC__GPT2_COMPARE2                   0x0258 0x04C8 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__EPDC_PWR_CTRL3                  0x0258 0x04C8 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11                      0x0258 0x04C8 0x0000 0x5 0x0
-- 
2.7.4
