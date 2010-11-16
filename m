From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 10:36:46 -0800 (PST)
Subject: [PATCH 4/5] mx51: Add IOMUX definition for PWM output pin
Message-ID: <642950.890.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |? ? 1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index e1600f3..fe249ad 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -379,6 +379,7 @@ typedef enum iomux_config {
 #define MX51_PAD_GPIO_1_2__GPIO_1_2??? ??? IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,???0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__I2C2_SCL??? ??? IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
 ??? ??? ??? ??? ??? ??? ??? 0x9b8,???3, MX51_I2C_PAD_CTRL)
+#define MX51_PAD_GPIO_1_2__PWM1_PWMO??? ??? IOMUX_PAD(0x7D4, 0x3CC, 1, 0x0,???0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_3__GPIO_1_3??? ??? IOMUX_PAD(0x7D8, 0x3D0, 0, 0x0,???0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_3__I2C2_SDA??? ??? IOMUX_PAD(0x7D8, 0x3D0, (2 | IOMUX_CONFIG_SION), \
 ??? ??? ??? ??? ??? ??? ??? 0x9bc,???3, MX51_I2C_PAD_CTRL)
-- 
1.6.0.4





      
