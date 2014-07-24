From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 24 Jul 2014 20:43:00 +0200
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable SBS battery support
Message-ID: <1406227380-3569-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Exynos5 boards (e.g: Snow, Peach Pit and Pi) have
a SBS-compliant gas gauge battery. Enable it as module
so the needed support is available for these boards.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index fc7d168..c390bb9 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
 CONFIG_I2C_S3C2410=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_SBS=m
 CONFIG_CHARGER_TPS65090=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
-- 
2.0.0.rc2
