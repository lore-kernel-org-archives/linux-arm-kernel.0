From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:21 +0100
Subject: [PATCH 5/7] ARM: at91: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352360783-17523-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Andrew Victor <linux@maxim.org.za>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91sam9g45.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 84af1b5..b7ae124 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -343,7 +343,6 @@ static struct at91_gpio_bank at91sam9g45_gpio[] __initdata = {
 static void __init at91sam9g45_map_io(void)
 {
 	at91_init_sram(0, AT91SAM9G45_SRAM_BASE, AT91SAM9G45_SRAM_SIZE);
-	init_consistent_dma_size(SZ_4M);
 }
 
 static void __init at91sam9g45_ioremap_registers(void)
-- 
1.7.9.5
