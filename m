From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 29 Aug 2018 09:52:57 +0300
Subject: [PATCH] ARM: configs: add generic resistive touchscreen
Message-ID: <1535525577-21148-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC to defconfigs

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sama5_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..a1b2cfa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -282,6 +282,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADC=m
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_WM97XX=m
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
