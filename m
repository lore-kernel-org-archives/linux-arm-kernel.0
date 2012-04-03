From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 Apr 2012 16:20:05 -0300
Subject: [PATCH 1/3] ARM: mx28: Register SPI clocks
Message-ID: <1333480807-10480-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register SPI clocks.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index cea29c9..add79a0 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -648,6 +648,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
 	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
 	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
+	_REGISTER_CLOCK("mxs-spi.0", NULL, ssp0_clk)
+	_REGISTER_CLOCK("mxs-spi.1", NULL, ssp1_clk)
+	_REGISTER_CLOCK("mxs-spi.2", NULL, ssp2_clk)
+	_REGISTER_CLOCK("mxs-spi.3", NULL, ssp3_clk)
 };
 
 static int clk_misc_init(void)
-- 
1.7.1
