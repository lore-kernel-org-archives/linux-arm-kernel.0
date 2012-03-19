From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 19 Mar 2012 17:12:45 +0200
Subject: [PATCH 1/2] ARM: OMAP3: hwmod_data: Rename the common irq for McBSP
 ports
Message-ID: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'common' as name for the common irq number in hwmod data for the McBSP
ports. The same name already in use for OMAP2430, and the OMAP4 hwmod data
will be using the same name.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..af84276 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2242,7 +2242,7 @@ static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
 
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
-	{ .name = "irq", .irq = 16 },
+	{ .name = "common", .irq = 16 },
 	{ .name = "tx", .irq = 59 },
 	{ .name = "rx", .irq = 60 },
 	{ .irq = -1 }
@@ -2293,7 +2293,7 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 
 /* mcbsp2 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
-	{ .name = "irq", .irq = 17 },
+	{ .name = "common", .irq = 17 },
 	{ .name = "tx", .irq = 62 },
 	{ .name = "rx", .irq = 63 },
 	{ .irq = -1 }
@@ -2349,7 +2349,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 
 /* mcbsp3 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
-	{ .name = "irq", .irq = 22 },
+	{ .name = "common", .irq = 22 },
 	{ .name = "tx", .irq = 89 },
 	{ .name = "rx", .irq = 90 },
 	{ .irq = -1 }
@@ -2405,7 +2405,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 
 /* mcbsp4 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp4_irqs[] = {
-	{ .name = "irq", .irq = 23 },
+	{ .name = "common", .irq = 23 },
 	{ .name = "tx", .irq = 54 },
 	{ .name = "rx", .irq = 55 },
 	{ .irq = -1 }
@@ -2462,7 +2462,7 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 
 /* mcbsp5 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp5_irqs[] = {
-	{ .name = "irq", .irq = 27 },
+	{ .name = "common", .irq = 27 },
 	{ .name = "tx", .irq = 81 },
 	{ .name = "rx", .irq = 82 },
 	{ .irq = -1 }
-- 
1.7.8.5
