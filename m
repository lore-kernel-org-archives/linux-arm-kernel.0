From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 19 Mar 2012 17:12:46 +0200
Subject: [PATCH 2/2] ARM: OMAP4: hwmod_data: Name the common irq for McBSP
 ports
In-Reply-To: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
References: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1332169966-25400-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'common' as name for the common irq number in hwmod data for the McBSP
ports. The same name already in use for OMAP2430, and OMAP3.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..f8058b7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2942,7 +2942,7 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 /* mcbsp1 */
 static struct omap_hwmod omap44xx_mcbsp1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] = {
-	{ .irq = 17 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "common", .irq = 17 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
@@ -3017,7 +3017,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 /* mcbsp2 */
 static struct omap_hwmod omap44xx_mcbsp2_hwmod;
 static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] = {
-	{ .irq = 22 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "common", .irq = 22 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
@@ -3092,7 +3092,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 /* mcbsp3 */
 static struct omap_hwmod omap44xx_mcbsp3_hwmod;
 static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] = {
-	{ .irq = 23 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "common", .irq = 23 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
@@ -3167,7 +3167,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 /* mcbsp4 */
 static struct omap_hwmod omap44xx_mcbsp4_hwmod;
 static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] = {
-	{ .irq = 16 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "common", .irq = 16 + OMAP44XX_IRQ_GIC_START },
 	{ .irq = -1 }
 };
 
-- 
1.7.8.5
