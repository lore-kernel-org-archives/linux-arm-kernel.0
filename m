From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Fri, 17 Jun 2011 16:02:53 +0200
Subject: [PATCH]OMAP2: remove unneeded comment
Message-ID: <4DFB5E8D.1060004@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the file was already renamed to clock3xxx_data.c

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/arch/arm/mach-omap2/clock3xxx_data.c
===================================================================
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3201,8 +3201,6 @@
 /*
  * clkdev
  */
-
-/* XXX At some point we should rename this file to clock3xxx_data.c */
 static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk,	CK_3XXX),
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
