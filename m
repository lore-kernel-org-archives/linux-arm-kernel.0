From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 May 2015 15:34:14 +0200
Subject: [RFC PATCH 4/4] ARM: exynos_defconfig: Enable user mode SPI device
 support
In-Reply-To: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1432042454-19234-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Exynos boards have SPI devices such as flash memories
that need to be accessed from user-space.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d034c96c039b..434d36ba87cb 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -91,6 +91,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SPI=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_I2C_S3C2410=y
+CONFIG_SPI_SPIDEV=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
-- 
2.1.4
