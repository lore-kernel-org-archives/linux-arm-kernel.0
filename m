From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 15 Jun 2011 09:59:35 -0300
Subject: [PATCH] ARM: mx53: Add SDMA clock
Message-ID: <1308142775-31574-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 6b89c1b..bbc837b 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1476,6 +1476,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.6.0.4
