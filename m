From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:09 +0200
Subject: [PATCH 33/40] ARM: mx5/iomux-mx51: Fix input path of some pins in
	gpio mode
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-33-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 9250273..639d631 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -274,15 +274,15 @@ typedef enum iomux_config {
 #define MX51_PAD_USBH1_DATA5__USBH1_DATA5       IOMUX_PAD(0x69C, 0x29C, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_DATA6__USBH1_DATA6       IOMUX_PAD(0x6A0, 0x2A0, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
 #define MX51_PAD_USBH1_DATA7__USBH1_DATA7       IOMUX_PAD(0x6A4, 0x2A4, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
-#define MX51_PAD_DI1_PIN11__GPIO_3_0            IOMUX_PAD(0x6A8, 0x2A8, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DI1_PIN12__GPIO_3_1            IOMUX_PAD(0x6AC, 0x2AC, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DI1_PIN13__GPIO_3_2            IOMUX_PAD(0x6B0, 0x2B0, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DI1_D0_CS__GPIO_3_3            IOMUX_PAD(0x6B4, 0x2B4, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DI1_D1_CS__GPIO_3_4            IOMUX_PAD(0x6B8, 0x2B8, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DISPB2_SER_DIN__GPIO_3_5       IOMUX_PAD(0x6BC, 0x2BC, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DISPB2_SER_DIO__GPIO_3_6       IOMUX_PAD(0x6C0, 0x2C0, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DISPB2_SER_CLK__GPIO_3_7       IOMUX_PAD(0x6C4, 0x2C4, 4, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_DISPB2_SER_RS__GPIO_3_8        IOMUX_PAD(0x6C8, 0x2C8, 4, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_DI1_PIN11__GPIO_3_0            IOMUX_PAD(0x6A8, 0x2A8, 4, 0x974, 1, NO_PAD_CTRL)
+#define MX51_PAD_DI1_PIN12__GPIO_3_1            IOMUX_PAD(0x6AC, 0x2AC, 4, 0x978, 1, NO_PAD_CTRL)
+#define MX51_PAD_DI1_PIN13__GPIO_3_2            IOMUX_PAD(0x6B0, 0x2B0, 4, 0x97c, 1, NO_PAD_CTRL)
+#define MX51_PAD_DI1_D0_CS__GPIO_3_3            IOMUX_PAD(0x6B4, 0x2B4, 4, 0x980, 1, NO_PAD_CTRL)
+#define MX51_PAD_DI1_D1_CS__GPIO_3_4            IOMUX_PAD(0x6B8, 0x2B8, 4, 0x984, 1, NO_PAD_CTRL)
+#define MX51_PAD_DISPB2_SER_DIN__GPIO_3_5       IOMUX_PAD(0x6BC, 0x2BC, 4, 0x988, 1, NO_PAD_CTRL)
+#define MX51_PAD_DISPB2_SER_DIO__GPIO_3_6       IOMUX_PAD(0x6C0, 0x2C0, 4, 0x98c, 1, NO_PAD_CTRL)
+#define MX51_PAD_DISPB2_SER_CLK__GPIO_3_7       IOMUX_PAD(0x6C4, 0x2C4, 4, 0x990, 1, NO_PAD_CTRL)
+#define MX51_PAD_DISPB2_SER_RS__GPIO_3_8        IOMUX_PAD(0x6C8, 0x2C8, 4, 0x994, 1, NO_PAD_CTRL)
 #define MX51_PAD_DISP1_DAT0__DISP1_DAT0         IOMUX_PAD(0x6CC, 0x2CC, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP1_DAT1__DISP1_DAT1         IOMUX_PAD(0x6D0, 0x2D0, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP1_DAT2__DISP1_DAT2         IOMUX_PAD(0x6D4, 0x2D4, 0, 0x0,   0, NO_PAD_CTRL)
-- 
1.7.2.3
