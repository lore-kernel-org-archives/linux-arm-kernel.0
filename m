From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:07 +0200
Subject: [PATCH 0104/1529] Fix typo
Message-ID: <20160521115007.4767-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/cm3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 187fa43..d91ae82 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -649,7 +649,7 @@ void omap3_cm_save_scratchpad_contents(u32 *ptr)
 	/*
 	 * As per erratum i671, ROM code does not respect the PER DPLL
 	 * programming scheme if CM_AUTOIDLE_PLL..AUTO_PERIPH_DPLL == 1.
-	 * Then,  in anycase, clear these bits to avoid extra latencies.
+	 * Then,  in any case, clear these bits to avoid extra latencies.
 	 */
 	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE) &
 		~OMAP3430_AUTO_PERIPH_DPLL_MASK;
-- 
2.8.2.534.g1f66975
