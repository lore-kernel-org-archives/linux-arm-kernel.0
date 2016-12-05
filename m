From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon,  5 Dec 2016 11:09:08 +0100
Subject: [PATCH v3 2/3] ARM: da850: coding style fix
In-Reply-To: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480932549-30811-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix alignment of the clock lookup table entries.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index c008e5e..006ec56 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -548,7 +548,7 @@ static struct clk_lookup da850_clks[] = {
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
