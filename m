From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 20 Jul 2010 09:16:13 +0200
Subject: [PATCH 2/3] iomux-mx51: add 4 pin definitions
In-Reply-To: <1279610174-6025-1-git-send-email-eric@eukrea.com>
References: <1279610174-6025-1-git-send-email-eric@eukrea.com>
Message-ID: <1279610174-6025-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 56ed0a6..21bfa46 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -215,9 +215,11 @@ typedef enum iomux_config {
 #define MX51_PAD_KEY_COL2__KEY_COL2             IOMUX_PAD(0x654, 0x264, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_KEY_COL3__KEY_COL3             IOMUX_PAD(0x658, 0x268, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_KEY_COL4__KEY_COL4             IOMUX_PAD(0x65C, 0x26C, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_KEY_COL4__UART3_RTS		IOMUX_PAD(0x65C, 0x26C, 2, 0x9f0, 4, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_KEY_COL4__I2C2_SCL		IOMUX_PAD(0x65C, 0x26C, (3 | IOMUX_CONFIG_SION), \
 							0x09b8, 1, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_KEY_COL5__KEY_COL5             IOMUX_PAD(0x660, 0x270, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_KEY_COL5__UART3_CTS		IOMUX_PAD(0x660, 0x270, 2, 0,     0, MX51_UART3_PAD_CTRL)
 #define MX51_PAD_KEY_COL5__I2C2_SDA		IOMUX_PAD(0x660, 0x270, (3 | IOMUX_CONFIG_SION), \
 							0x09bc, 1, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_USBH1_CLK__USBH1_CLK           IOMUX_PAD(0x678, 0x278, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
@@ -307,7 +309,11 @@ typedef enum iomux_config {
 #define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
+							0x9b8,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_GPIO_1_3__GPIO_1_3		IOMUX_PAD(0x7D8, 0x3D0, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_3__I2C2_SDA		IOMUX_PAD(0x7D8, 0x3D0, (2 | IOMUX_CONFIG_SION), \
+							0x9bc,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
-- 
1.6.3.3
