From: tony@atomide.com (Tony Lindgren)
Date: Wed, 05 May 2010 12:33:09 -0700
Subject: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC clocks
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Message-ID: <20100505193308.21568.98880.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sriram <srk@ti.com>

The emac driver uses generic name for the module and phy
clocks. Updated the omap3xxx_clks table to match the names
used by the Davinci emac driver.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..6905eb7 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3472,8 +3472,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
 	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
-	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
+	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
+	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
 	CLK("musb_hdrc",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
