From: yannick.fertre@st.com (Yannick Fertre)
Date: Mon, 16 Jan 2017 14:29:04 +0100
Subject: [PATCH v1 7/7] ARM: configs: Add STM32 LTDC support in STM32 defconfig
In-Reply-To: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1484573344-11609-8-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 29068f5..e3974d9 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -71,3 +71,8 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_FTRACE is not set
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
+CONFIG_DRM=y
+CONFIG_DRM_ST=y
+CONFIG_DRM_PANEL=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.9.1
