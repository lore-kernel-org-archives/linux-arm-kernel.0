From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:32 -0700
Subject: [PATCH 12/28] OMAP4: Clocks: Change SPI Instance Names
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231132.31953.60178.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abraham Arce <x0066660@ti.com>

Change the name for the spi instances on omap44xx_clks to match
the names omap2 spi driver gives:

omap-mcspi.1 -> omap2_mcspi.1
omap-mcspi.2 -> omap2_mcspi.2
omap-mcspi.3 -> omap2_mcspi.3
omap-mcspi.4 -> omap2_mcspi.4

Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 28b1079..a5c0c9c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2671,10 +2671,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("omap-mcspi.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.1",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
+	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
