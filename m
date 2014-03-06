From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu,  6 Mar 2014 12:32:30 +0100
Subject: [PATCH V2 10/12] ARM: shmobile: r7s72100: remove I2C DT clocks from
 legacy clock support
In-Reply-To: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394105552-9744-11-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Not used anymore since we switched to CCF.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index f17a5db00221..dd14cfb7ac12 100644
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
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
-- 
1.9.0
