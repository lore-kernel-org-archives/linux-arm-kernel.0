From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 29 Aug 2012 11:00:00 +0200
Subject: [PATCH] ARM: tegra_defconfig: enable APB DMA support
Message-ID: <1346230800-3167-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additionally DMADEVICES needs to be enabled as TEGRA20_APB_DMA depends
on that.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index db22453..0d6bb73 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -145,6 +145,8 @@ CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_DMADEVICES=y
+CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
1.7.10.4
