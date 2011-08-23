From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Aug 2011 16:35:31 +0200
Subject: [PATCH] at91sam9261: fix typo in t2_clk alias for atmel_tcb.0
Message-ID: <1314110131-32651-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Remy Bohmer <linux@bohmer.net>
---
Hi,

	I'm in traveling right now
	please test this patch

	this will fix your issue on sam9261

Best Regards,
J.
 arch/arm/mach-at91/at91sam9261.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index d522b47..6c8e3b5 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -157,7 +157,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
-	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc1_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
-- 
1.7.5.4
