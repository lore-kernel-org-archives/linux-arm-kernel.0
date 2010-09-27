From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:08 +0200
Subject: [PATCH 32/40] ARM: mx5/iomux-mx51: Add aud3 primary function defines
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-32-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index c885f89..9250273 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -214,9 +214,13 @@ typedef enum iomux_config {
 #define MX51_PAD_I2C1_CLK__HSI2C_CLK		IOMUX_PAD(0x5E8, 0x1F8, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_I2C1_DAT__GPIO_4_17            IOMUX_PAD(0x5EC, 0x1FC, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_I2C1_DAT__HSI2C_DAT		IOMUX_PAD(0x5EC, 0x1FC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_AUD3_BB_TXD__AUD3_BB_TXD       IOMUX_PAD(0x5F0, 0x200, IOMUX_CONFIG_SION, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_TXD__GPIO_4_18         IOMUX_PAD(0x5F0, 0x200, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_AUD3_BB_RXD__AUD3_BB_RXD       IOMUX_PAD(0x5F4, 0x204, IOMUX_CONFIG_SION, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_RXD__GPIO_4_19         IOMUX_PAD(0x5F4, 0x204, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_AUD3_BB_CK__AUD3_BB_CK         IOMUX_PAD(0x5F8, 0x208, IOMUX_CONFIG_SION, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_CK__GPIO_4_20          IOMUX_PAD(0x5F8, 0x208, 3, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_AUD3_BB_FS__AUD3_BB_FS         IOMUX_PAD(0x5FC, 0x20C, IOMUX_CONFIG_SION, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_AUD3_BB_FS__GPIO_4_21          IOMUX_PAD(0x5FC, 0x20C, 3, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_MOSI__CSPI1_MOSI         IOMUX_PAD(0x600, 0x210, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_CSPI1_MOSI__GPIO_4_22          IOMUX_PAD(0x600, 0x210, 3, 0x0,   0, NO_PAD_CTRL)
-- 
1.7.2.3
