From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 21 Mar 2012 19:03:12 +0100
Subject: [PATCH 2/4] arm: at91: at91sam9x5 add mci clk_lookup
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1332352994-20983-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..39cbef3 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -225,6 +225,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f000c000.mmc", &mmc1_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
-- 
1.7.5.4
