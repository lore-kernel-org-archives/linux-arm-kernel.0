From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Oct 2010 11:39:51 +0200
Subject: =?UTF-8?q?=5BPATCH=5D=20ARM=3A=20iomux-mx51=3A=20Add=20AUD5=20pinmux=20definitions?=
Message-ID: <1286530791-23105-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 633650d..0d89854 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -334,11 +334,17 @@ typedef enum iomux_config {
 #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CMD__AUD5_RXFS             IOMUX_PAD(0x79C, 0x394, 1, 0x8e0, 1, NO_PAD_CTRL)
 #define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CLK__AUD5_RXC              IOMUX_PAD(0x7A0, 0x398, 1, 0x8dc, 1, NO_PAD_CTRL)
 #define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA0__AUD5_TXD            IOMUX_PAD(0x7A4, 0x39C, 1, 0x8d8, 1, NO_PAD_CTRL)
 #define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA1__AUD5_RXD            IOMUX_PAD(0x7A8, 0x3A0, 1, 0x8d4, 2, NO_PAD_CTRL)
 #define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA2__AUD5_TXC            IOMUX_PAD(0x7AC, 0x3A4, 1, 0x8e4, 2, NO_PAD_CTRL)
 #define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_DATA3__AUD5_TXFS           IOMUX_PAD(0x7B0, 0x3A8, 1, 0x8e8, 2, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
-- 
1.7.2.3
