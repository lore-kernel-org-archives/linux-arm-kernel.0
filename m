From: govindraj.raja@ti.com (Govindraj.R)
Date: Wed, 1 Dec 2010 19:31:51 +0530 (IST)
Subject: [PATCH 5/7 v2] OMAP3: clocks: Update clock domain name for mcspi fck
Message-ID: <33288.10.24.255.18.1291212111.squirrel@dbdmail.itg.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Charulatha V <charu@ti.com>

Update clock3xxx_data for mcspi1-4 with appropriate clock domain name.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..5c02baa 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1558,6 +1558,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi3_fck = {
@@ -1567,6 +1568,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi2_fck = {
@@ -1576,6 +1578,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi1_fck = {
@@ -1585,6 +1588,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk uart2_fck = {
-- 
1.7.1
