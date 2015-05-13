From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 14:32:07 +0930
Subject: [PATCHv3 3/3] ARM: exynos_defconfig: Enable LEDs for Odroid-XU3
In-Reply-To: <1431493327-5387-1-git-send-email-linux.amoon@gmail.com>
References: <1431493327-5387-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1431493327-5387-4-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_LEDS_GPIO, CONFIG_LEDS_TRIGGERS and
CONFIG_LEDS_TRIGGER_HEARTBEAT on Odroid-XU3
to support dts led changes.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/configs/exynos_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 300678a..21411c5 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -179,6 +179,9 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=y
-- 
1.9.1
