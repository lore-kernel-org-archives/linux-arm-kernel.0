From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:07 +0200
Subject: [PATCH 31/40] ARM: mx5/iomux-mx51: Add SPI controller pads
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-31-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index d0ef881..c885f89 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -218,11 +218,17 @@ typedef enum iomux_config {
 #define MX51_PAD_AUD3_BB_RXD__GPIO_4_19         IOMUX_PAD(0x5F4, 0x204, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_CK__GPIO_4_20          IOMUX_PAD(0x5F8, 0x208, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_FS__GPIO_4_21          IOMUX_PAD(0x5FC, 0x20C, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_MOSI__CSPI1_MOSI         IOMUX_PAD(0x600, 0x210, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_MOSI__GPIO_4_22          IOMUX_PAD(0x600, 0x210, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_MISO__CSPI1_MISO         IOMUX_PAD(0x604, 0x214, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_MISO__GPIO_4_23          IOMUX_PAD(0x604, 0x214, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_SS0__CSPI1_SS0           IOMUX_PAD(0x608, 0x218, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_SS0__GPIO_4_24           IOMUX_PAD(0x608, 0x218, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_SS1__CSPI1_SS1           IOMUX_PAD(0x60C, 0x21C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_SS1__GPIO_4_25           IOMUX_PAD(0x60C, 0x21C, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_RDY__CSPI1_RDY           IOMUX_PAD(0x610, 0x220, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_RDY__GPIO_4_26           IOMUX_PAD(0x610, 0x220, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_CSPI1_SCLK__CSPI1_SCLK         IOMUX_PAD(0x614, 0x224, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_SCLK__GPIO_4_27          IOMUX_PAD(0x614, 0x224, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_UART1_RXD__UART1_RXD           IOMUX_PAD(0x618, 0x228, 0, 0x9e4, 0, MX51_UART1_PAD_CTRL | PAD_CTL_SRE_FAST)
 #define MX51_PAD_UART1_TXD__UART1_TXD           IOMUX_PAD(0x61C, 0x22C, 0, 0x0,   0, MX51_UART1_PAD_CTRL | PAD_CTL_SRE_FAST)
-- 
1.7.2.3
