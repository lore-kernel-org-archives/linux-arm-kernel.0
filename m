From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 23 Feb 2011 16:58:38 +0000
Subject: [PATCH 3/4] MX1: Register clock for SPI2
In-Reply-To: <1298480319-72386-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1298480319-72386-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<1298480319-72386-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1298480319-72386-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/mach-imx/clock-imx1.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index 3938a56..dcc4172 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -592,6 +592,7 @@ static struct clk_lookup lookups[] __initdata = {
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
 	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
+	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
 	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
 	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-- 
1.7.3.4
