From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:33 +0900
Subject: [PATCH 08/12] ARM: shmobile: r7s72100: remove I2C DT clocks from
 legacy clock support
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <316b9353784386aedc4f2643dfdfda30da268b0b.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not used anymore since we switched to CCF.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 644f1c2..1a797fe 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -199,10 +199,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e800d800.spi", &mstp_clks[MSTP105]),
 	CLKDEV_DEV_ID("e800e000.spi", &mstp_clks[MSTP104]),
 	CLKDEV_DEV_ID("e800e800.spi", &mstp_clks[MSTP103]),
-	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
-	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
-	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
-	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
 	CLKDEV_DEV_ID("r7s72100-ether", &mstp_clks[MSTP74]),
 
 	/* ICK */
-- 
1.8.5.2
