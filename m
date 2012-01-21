From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:31 +0900
Subject: [PATCH 5/7] ARM: S5PC100: use static declaration when it is not used
 in other files
Message-ID: <010d01ccd7f6$3f57b120$be071360$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |   28 ++++++++++++++--------------
 arch/arm/mach-s5pc100/dma.c   |   12 ++++++------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 247194d..16eca4e 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -170,7 +170,7 @@ static struct clk *clk_src_mout_am_list[] = {
 	[1] = &clk_div_apll2.clk,
 };
 
-struct clksrc_sources clk_src_mout_am = {
+static struct clksrc_sources clk_src_mout_am = {
 	.sources	= clk_src_mout_am_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_mout_am_list),
 };
@@ -212,7 +212,7 @@ static struct clk *clk_src_mout_onenand_list[] = {
 	[1] = &clk_div_d1_bus.clk,
 };
 
-struct clksrc_sources clk_src_mout_onenand = {
+static struct clksrc_sources clk_src_mout_onenand = {
 	.sources	= clk_src_mout_onenand_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_mout_onenand_list),
 };
@@ -756,7 +756,7 @@ static struct clk *clk_src_group1_list[] = {
 	[3] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_group1 = {
+static struct clksrc_sources clk_src_group1 = {
 	.sources	= clk_src_group1_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group1_list),
 };
@@ -766,7 +766,7 @@ static struct clk *clk_src_group2_list[] = {
 	[1] = &clk_div_mpll.clk,
 };
 
-struct clksrc_sources clk_src_group2 = {
+static struct clksrc_sources clk_src_group2 = {
 	.sources	= clk_src_group2_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group2_list),
 };
@@ -780,7 +780,7 @@ static struct clk *clk_src_group3_list[] = {
 	[5] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_group3 = {
+static struct clksrc_sources clk_src_group3 = {
 	.sources	= clk_src_group3_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group3_list),
 };
@@ -806,7 +806,7 @@ static struct clk *clk_src_group4_list[] = {
 	[5] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_group4 = {
+static struct clksrc_sources clk_src_group4 = {
 	.sources	= clk_src_group4_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group4_list),
 };
@@ -831,7 +831,7 @@ static struct clk *clk_src_group5_list[] = {
 	[4] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_group5 = {
+static struct clksrc_sources clk_src_group5 = {
 	.sources	= clk_src_group5_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group5_list),
 };
@@ -854,7 +854,7 @@ static struct clk *clk_src_group6_list[] = {
 	[2] = &clk_div_hdmi.clk,
 };
 
-struct clksrc_sources clk_src_group6 = {
+static struct clksrc_sources clk_src_group6 = {
 	.sources	= clk_src_group6_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group6_list),
 };
@@ -866,7 +866,7 @@ static struct clk *clk_src_group7_list[] = {
 	[3] = &clk_vclk54m,
 };
 
-struct clksrc_sources clk_src_group7 = {
+static struct clksrc_sources clk_src_group7 = {
 	.sources	= clk_src_group7_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_group7_list),
 };
@@ -877,7 +877,7 @@ static struct clk *clk_src_mmc0_list[] = {
 	[2] = &clk_fin_epll,
 };
 
-struct clksrc_sources clk_src_mmc0 = {
+static struct clksrc_sources clk_src_mmc0 = {
 	.sources	= clk_src_mmc0_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_mmc0_list),
 };
@@ -889,7 +889,7 @@ static struct clk *clk_src_mmc12_list[] = {
 	[3] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_mmc12 = {
+static struct clksrc_sources clk_src_mmc12 = {
 	.sources	= clk_src_mmc12_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_mmc12_list),
 };
@@ -901,7 +901,7 @@ static struct clk *clk_src_irda_usb_list[] = {
 	[3] = &clk_mout_hpll.clk,
 };
 
-struct clksrc_sources clk_src_irda_usb = {
+static struct clksrc_sources clk_src_irda_usb = {
 	.sources	= clk_src_irda_usb_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_irda_usb_list),
 };
@@ -912,7 +912,7 @@ static struct clk *clk_src_pwi_list[] = {
 	[2] = &clk_div_mpll.clk,
 };
 
-struct clksrc_sources clk_src_pwi = {
+static struct clksrc_sources clk_src_pwi = {
 	.sources	= clk_src_pwi_list,
 	.nr_sources	= ARRAY_SIZE(clk_src_pwi_list),
 };
@@ -923,7 +923,7 @@ static struct clk *clk_sclk_spdif_list[] = {
 	[2] = &clk_sclk_audio2.clk,
 };
 
-struct clksrc_sources clk_src_sclk_spdif = {
+static struct clksrc_sources clk_src_sclk_spdif = {
 	.sources	= clk_sclk_spdif_list,
 	.nr_sources	= ARRAY_SIZE(clk_sclk_spdif_list),
 };
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index c841f4d..395e46b 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -35,7 +35,7 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-u8 pdma0_peri[] = {
+static u8 pdma0_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -68,12 +68,12 @@ u8 pdma0_peri[] = {
 	DMACH_HSI_TX,
 };
 
-struct dma_pl330_platdata s5pc100_pdma0_pdata = {
+static struct dma_pl330_platdata s5pc100_pdma0_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
 	.peri_id = pdma0_peri,
 };
 
-struct amba_device s5pc100_device_pdma0 = {
+static struct amba_device s5pc100_device_pdma0 = {
 	.dev = {
 		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
@@ -89,7 +89,7 @@ struct amba_device s5pc100_device_pdma0 = {
 	.periphid = 0x00041330,
 };
 
-u8 pdma1_peri[] = {
+static u8 pdma1_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -122,12 +122,12 @@ u8 pdma1_peri[] = {
 	DMACH_MSM_REQ3,
 };
 
-struct dma_pl330_platdata s5pc100_pdma1_pdata = {
+static struct dma_pl330_platdata s5pc100_pdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
 	.peri_id = pdma1_peri,
 };
 
-struct amba_device s5pc100_device_pdma1 = {
+static struct amba_device s5pc100_device_pdma1 = {
 	.dev = {
 		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
-- 
1.7.1
