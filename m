From: yannick.fertre@st.com (Yannick Fertre)
Date: Thu, 6 Apr 2017 14:19:28 +0200
Subject: [PATCH v5 5/5] ARM: configs: stm32: Add watchdog support in STM32
 defconfig
In-Reply-To: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
References: <1491481168-22213-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1491481168-22213-6-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds STM32 watchdog support in stm32_defconfig file

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 29ac5a4..1fb901c 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -51,6 +51,7 @@ CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_STM32F4=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
-- 
1.9.1
