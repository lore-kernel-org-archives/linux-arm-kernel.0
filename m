From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 10:27:06 +0900
Subject: [PATCH 2/4] ARM: exynos_defconfig: Enable Maxim 77693 LED and haptic
 drivers
In-Reply-To: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
References: <1444699628-3774-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444699628-3774-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for:
1. Haptic motor driver on Trats2 board (Maxim 77693) and Note 4
   (Maxim 77843);
2. LED driver on Trats2 board (Maxim 77693).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 0bf9c31f4661..bbb4228b76a2 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -75,6 +75,7 @@ CONFIG_MOUSE_CYAPA=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MAX77693_HAPTIC=y
 CONFIG_INPUT_MAX8997_HAPTIC=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_SAMSUNG=y
@@ -179,8 +180,10 @@ CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_CLASS_FLASH=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
+CONFIG_LEDS_MAX77693=y
 CONFIG_LEDS_MAX8997=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-- 
1.9.1
