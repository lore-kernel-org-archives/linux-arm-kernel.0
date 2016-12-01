From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu,  1 Dec 2016 18:15:15 +0100
Subject: [PATCH 2/3] ARM: da850: coding style fix
In-Reply-To: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480612516-18853-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix alignment of the clock lookup table entries.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1e11ce8..855b720 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -542,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci_da850",		NULL,		&sata_clk),
+	CLK("ahci_da850",	NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
 	CLK(NULL,		NULL,		&ehrpwm_clk),
 	CLK("ehrpwm.0",		"fck",		&ehrpwm0_clk),
-- 
2.9.3
