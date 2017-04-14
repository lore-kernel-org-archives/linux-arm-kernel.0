From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 14 Apr 2017 12:13:38 +0200
Subject: [PATCH v7 8/9] ARM: configs: stm32: Add DRM support in STM32 defconfig
In-Reply-To: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
References: <1492164819-10513-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1492164819-10513-9-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DRM (Direct Rendering Manager) support
in stm32_defconfig file

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..c2ff2e7 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -48,6 +48,7 @@ CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_DRM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
-- 
1.9.1
