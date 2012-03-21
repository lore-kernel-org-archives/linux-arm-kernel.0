From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Mar 2012 15:13:00 +0100
Subject: [PATCH] ARM: at91/at91sam9x5: add clkdev entries for DMA controllers
Message-ID: <1332339180-4670-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index b6831ee..13c8cae 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -223,6 +223,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "f8028000.serial", &usart3_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
+	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
+	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
-- 
1.7.9
