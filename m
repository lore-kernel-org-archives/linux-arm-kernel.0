From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 17 Nov 2014 18:43:04 +0100
Subject: [PATCH 3/3] ARM: exynos_defconfig: Enable user mode SPI device support
In-Reply-To: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1416246184-29071-4-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Exynos boards have SPI devices such as flash memories that can be
accessed from user-space. Enable support for the SPI usermode interface.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index da7e9cf..5de8b58 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -80,6 +80,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SPI=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_I2C_S3C2410=y
+CONFIG_SPI_SPIDEV=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
-- 
2.1.0
