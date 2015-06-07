From: linux.amoon@gmail.com (Anand Moon)
Date: Mon,  8 Jun 2015 02:33:41 +0930
Subject: [PATCHv2 2/2] ARM: exynos_defconfig: Enable CONFIG_LEDS_PWM for
 Odroid-XU3
In-Reply-To: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
References: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1433696621-4763-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_LEDS_PWM amd CONFIG_LEDS_TRIGGER_HEARTBEAT for
Odroid-XU3 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1b7253b..2bbdf80 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -165,6 +165,12 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_PWM=m
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=m
+CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=y
-- 
2.4.3
