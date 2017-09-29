From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 29 Sep 2017 17:14:11 +0200
Subject: [PATCH] ARM: configs: stm32: Update default configuration for
 v4.14-rc1
Message-ID: <1506698051-23983-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regenerate the default configuration on top of v4.14-rc1.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 90e5c46..3ed3158 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -18,7 +18,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
-CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_STM32=y
 CONFIG_CPU_V7M_NUM_IRQ=240
 CONFIG_SET_MEM_PARAM=y
@@ -44,18 +43,17 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_STM32F4=y
+CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-CONFIG_REGULATOR=y
-CONFIG_GPIO_STMPE=y
 CONFIG_MFD_STMPE=y
+CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
@@ -81,8 +79,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_FTRACE is not set
 CONFIG_CRYPTO=y
-CONFIG_CRYPTO_DEV_STM32=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
-- 
2.7.4
