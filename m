From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:45 +0100
Subject: [PATCH v2 08/12] at91: sam9261: Add a clock definition for the smc
In-Reply-To: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1389270709-32662-9-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/at91sam9261.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index a67bfe6..cb5f906 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -205,6 +205,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioA_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioB_clk),
 	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioC_clk),
+	CLKDEV_CON_DEV_ID("smc", "ffffec00.smc", &mck),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
-- 
1.8.5.2
