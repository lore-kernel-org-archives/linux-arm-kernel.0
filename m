From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:17 +0200
Subject: [PATCH 1/6] i.MX27 clock: rename spi clocks to match device
In-Reply-To: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
References: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/clock_imx27.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index 4089951..174fa3e 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -638,9 +638,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
 	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
 	_REGISTER_CLOCK("mxc-mmc.2", NULL, sdhc3_clk)
-	_REGISTER_CLOCK(NULL, "cspi1", cspi1_clk)
-	_REGISTER_CLOCK(NULL, "cspi2", cspi2_clk)
-	_REGISTER_CLOCK(NULL, "cspi3", cspi3_clk)
+	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
+	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
+	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
 	_REGISTER_CLOCK(NULL, "csi", csi_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
-- 
1.6.4.3
