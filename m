From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 03:10:14 +0200
Subject: [PATCH v6 10/12] ARM: shmobile: r7s72100: remove SPI DT clocks from
 legacy clock support
In-Reply-To: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1400029816-24028-11-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not used anymore since we switched to CCF.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 1a797fe9e42f..df187484de5d 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -194,11 +194,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("rspi-rz.2", &mstp_clks[MSTP105]),
 	CLKDEV_DEV_ID("rspi-rz.3", &mstp_clks[MSTP104]),
 	CLKDEV_DEV_ID("rspi-rz.4", &mstp_clks[MSTP103]),
-	CLKDEV_DEV_ID("e800c800.spi", &mstp_clks[MSTP107]),
-	CLKDEV_DEV_ID("e800d000.spi", &mstp_clks[MSTP106]),
-	CLKDEV_DEV_ID("e800d800.spi", &mstp_clks[MSTP105]),
-	CLKDEV_DEV_ID("e800e000.spi", &mstp_clks[MSTP104]),
-	CLKDEV_DEV_ID("e800e800.spi", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("r7s72100-ether", &mstp_clks[MSTP74]),
 
 	/* ICK */
-- 
1.9.2
