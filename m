From: code@mmayer.net (Markus Mayer)
Date: Wed, 19 Apr 2017 13:18:11 -0700
Subject: [PATCH] soc: brcmstb: enable drivers for ARM64 also
Message-ID: <20170419201811.70246-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

We enable the BRCMSTB SoC drivers not only for ARM, but also ARM64.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/soc/bcm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index a39b0d5..b3834b9 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -11,7 +11,7 @@ config RASPBERRYPI_POWER
 
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
-	depends on ARM
+	depends on ARM || ARM64
 	select SOC_BUS
 	help
 	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
-- 
2.7.4
