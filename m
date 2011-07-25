From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Jul 2011 17:47:54 +0200
Subject: [PATCH 2/2] ARM: tegra: enable rtc driver in defconfig
In-Reply-To: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1311608874-31863-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8845f1c..d87631f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -98,6 +98,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_TEGRA=m
 CONFIG_STAGING=y
 # CONFIG_STAGING_EXCLUDE_BUILD is not set
 CONFIG_IIO=y
-- 
1.7.5.4
