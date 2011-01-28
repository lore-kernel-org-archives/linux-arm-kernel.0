From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 Jan 2011 08:58:16 +0100
Subject: [PATCH 1/2] mach-ux500: set sd/mmc clock rate to 100MHz
Message-ID: <1296201496-22862-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@stericsson.com>

The clock speed for the SD/MMC clock was incorrect, rectify it.

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index b2b0a3b..9a0a6ed 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -313,7 +313,7 @@ static DEFINE_PRCMU_CLK_RATE(uartclk,	0x0, 5, UARTCLK, 38400000);
 static DEFINE_PRCMU_CLK(msp02clk,	0x0, 6, MSP02CLK);
 static DEFINE_PRCMU_CLK(msp1clk,	0x0, 7, MSP1CLK); /* v1 */
 static DEFINE_PRCMU_CLK_RATE(i2cclk,	0x0, 8, I2CCLK, 48000000);
-static DEFINE_PRCMU_CLK_RATE(sdmmcclk,	0x0, 9, SDMMCCLK, 50000000);
+static DEFINE_PRCMU_CLK_RATE(sdmmcclk,	0x0, 9, SDMMCCLK, 100000000);
 static DEFINE_PRCMU_CLK(slimclk,	0x0, 10, SLIMCLK);
 static DEFINE_PRCMU_CLK(per1clk,	0x0, 11, PER1CLK);
 static DEFINE_PRCMU_CLK(per2clk,	0x0, 12, PER2CLK);
-- 
1.7.3.2
