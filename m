From: yannick.fertre@st.com (Yannick Fertre)
Date: Tue, 28 Mar 2017 11:44:53 +0200
Subject: [PATCH v5 10/10] ARM: configs: stm32: Add simple panel support in
 STM32 defconfig
In-Reply-To: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
References: <1490694293-18358-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490694293-18358-11-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds simple panel support in stm32_defconfig file

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 562d351..ae68d9f 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -50,6 +50,8 @@ CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_MFD_SYSCON=y
-- 
1.9.1
