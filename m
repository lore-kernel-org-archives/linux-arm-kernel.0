From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  7 Feb 2018 14:45:53 +0100
Subject: [PATCH 7/7] ARM: davinci_all_defconfig: select the DaVinci genpd
 driver in DT mode
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Message-ID: <20180207134553.13510-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can now use the generic power domains driver in DT mode. Reflect
that in the defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a5d9fcd9dd9c..3bff3b78b0c3 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -211,6 +211,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_SOC_DAVINCI=y
+CONFIG_DAVINCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
-- 
2.16.1
