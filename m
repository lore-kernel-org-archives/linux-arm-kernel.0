From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 15 Mar 2017 18:02:14 +0100
Subject: [PATCH v4 8/8] ARM: configs: Add STM32 panel simple support in STM32
 defconfig
In-Reply-To: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1489597334-16896-9-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 9c6ba54e..f7ddf29b 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -50,6 +50,8 @@ CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_MFD_SYSCON=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
-- 
1.9.1
