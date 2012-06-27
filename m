From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:18 +0200
Subject: [PATCH 8/8] ARM: LPC32xx: Remove unused gpios
In-Reply-To: <1340835978-20331-1-git-send-email-stigge@antcom.de>
References: <1340835978-20331-1-git-send-email-stigge@antcom.de>
Message-ID: <1340835978-20331-9-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Remove SPI0_CS, MMC_CD and MMC_WP gpios as they moved to devicetree.

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/phy3250.c |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -51,12 +51,9 @@
 /*
  * Mapped GPIOLIB GPIOs
  */
-#define SPI0_CS_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
 #define LCD_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
 #define BKL_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
 #define MMC_PWR_ENABLE_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 5)
-#define MMC_CD_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 1)
-#define MMC_WP_GPIO		LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 0)
 
 /*
  * AMBA LCD controller
