From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:13 +0200
Subject: [PATCH 0105/1529] Fix typo
Message-ID: <20160521115013.4816-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/mux34xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index be271f1..393e687 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -1266,7 +1266,7 @@ static struct omap_ball __initdata omap3_cus_ball[] = {
 #endif
 
 /*
- * Signals different on CBB package comapared to superset
+ * Signals different on CBB package compared to superset
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBB)
 static struct omap_mux __initdata omap3_cbb_subset[] = {
@@ -1597,7 +1597,7 @@ static struct omap_ball __initdata omap3_cbb_ball[] = {
 #endif
 
 /*
- * Signals different on 36XX CBP package comapared to 34XX CBC package
+ * Signals different on 36XX CBP package compared to 34XX CBC package
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBP)
 static struct omap_mux __initdata omap36xx_cbp_subset[] = {
-- 
2.8.2.534.g1f66975
