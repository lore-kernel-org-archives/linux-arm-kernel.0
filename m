From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 29 Aug 2018 17:17:43 +0300
Subject: [PATCH v2 1/2] ARM: configs: at91: add generic resistive touchscreen
 to sama5
Message-ID: <1535552264-8923-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC to sama5_defconfig

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- split config change into two commits, per defconfig

 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2080025..ead6826 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -116,6 +116,7 @@ CONFIG_KEYBOARD_QT1070=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADC=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=y
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=4
-- 
2.7.4
