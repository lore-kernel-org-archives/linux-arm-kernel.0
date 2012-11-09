From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:32:12 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh7372: remove fsidivx clock
In-Reply-To: <1352446333-20082-1-git-send-email-horms@verge.net.au>
References: <1352446333-20082-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446333-20082-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

fsidivx clock is no longer needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 4d57e34..fbd1863 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -507,8 +507,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pllc1_clk", &pllc1_clk),
 	CLKDEV_CON_ID("pllc1_div2_clk", &pllc1_div2_clk),
 	CLKDEV_CON_ID("pllc2_clk", &sh7372_pllc2_clk),
-	CLKDEV_CON_ID("fsidiva", &fsidivs[FSIDIV_A]),
-	CLKDEV_CON_ID("fsidivb", &fsidivs[FSIDIV_B]),
 
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("i_clk", &div4_clks[DIV4_I]),
-- 
1.7.10.4
