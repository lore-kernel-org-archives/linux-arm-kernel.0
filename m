From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 30 Apr 2014 14:43:27 +0300
Subject: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
Message-ID: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HWMOD_SWSUP_SIDLE to flags.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 892317294fdc..e829664e6a6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -895,7 +895,7 @@ static struct omap_hwmod omap54xx_mcpdm_hwmod = {
 	 * current exception.
 	 */
 
-	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
 	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.9.2
