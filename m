From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:23 -0300
Subject: [PATCH v2 1/6] ARM: mach-imx/mx27_3ds: Use the standard i.MX macro
	for GPIO numbering
Message-ID: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch

 arch/arm/mach-imx/mach-mx27_3ds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 09ec036..3a58448 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -42,9 +42,9 @@
 
 #include "devices-imx27.h"
 
-#define SD1_EN_GPIO (GPIO_PORTB + 25)
-#define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
-#define SPI2_SS0 (GPIO_PORTD + 21)
+#define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
+#define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
+#define SPI2_SS0		IMX_GPIO_NR(4, 21)
 #define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
 
 static const int mx27pdk_pins[] __initconst = {
-- 
1.6.0.4
