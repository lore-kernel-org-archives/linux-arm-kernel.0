From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 10 Feb 2017 15:54:49 +0100
Subject: [PATCH v2 9/9] ARM: configs: stm32: ADD LDTC support
In-Reply-To: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1486738489-22154-10-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/configs/stm32_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index e995209..d6a00b8 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -70,3 +70,8 @@ CONFIG_MAGIC_SYSRQ=y
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
