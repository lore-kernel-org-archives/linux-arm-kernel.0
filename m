From: linux.amoon@gmail.com (Anand Moon)
Date: Thu,  3 Sep 2015 05:38:16 +0000
Subject: [PATCHv6] ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
Message-ID: <1441258696-3699-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable config option NEW_LEDS, LEDS_CLASS, LEDS_GPIO, LEDS_PWM,
LEDS_TRIGGERS, LEDS_TRIGGER_TIMER, LEDS_TRIGGER_HEARTBEAT for
Odroid-XU3/XU4 board.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>

---
Changes from last version
dropped following option.
  CONFIG_LEDS_CLASS_FLASH
  CONFIG_TRIGGER_ONESHOT
  CONFIG_TRIGGER_GPIO
fixed the From address
---
 arch/arm/configs/exynos_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9504e77..aaf7aa4 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -163,6 +163,13 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PWM=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=y
-- 
2.1.4
