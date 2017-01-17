From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 17 Jan 2017 16:27:01 +0100
Subject: [PATCH v9 5/5] ARM: configs: stm32: Add I2C support for STM32
 defconfig
In-Reply-To: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1484666821-20551-6-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C support for STM32 default configuration

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/configs/stm32_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 5a72d69..323d2a3 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -47,6 +47,9 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_STM32F4=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
-- 
1.9.1
