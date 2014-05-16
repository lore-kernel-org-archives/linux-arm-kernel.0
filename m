From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:35 +0900
Subject: [PATCH 10/12] ARM: shmobile: r7s72100: remove SPI DT clocks from
 legacy clock support
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <3158e053ff45ed36d531d775cf0040642b91b606.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not used anymore since we switched to CCF.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 1a797fe..df18748 100644
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
1.8.5.2
