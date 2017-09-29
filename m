From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 29 Sep 2017 14:13:13 +0200
Subject: [PATCH v1] ARM: configs: stm32: Add I2C support in STM32 defconfig
Message-ID: <1506687193-21159-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C support for STM32

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v1:
        * Initial
---
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 3ed3158..80c7406 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -49,6 +49,7 @@ CONFIG_SERIAL_STM32_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_STM32F4=y
+CONFIG_I2C_STM32F7=y
 CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-- 
2.7.4
