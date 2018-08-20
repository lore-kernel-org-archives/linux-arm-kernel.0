From: yannick.fertre@st.com (=?UTF-8?q?Yannick=20Fertr=C3=A9?=)
Date: Mon, 20 Aug 2018 16:50:12 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable panel RM68200
Message-ID: <1534776612-4448-1-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable panel raydium RM68200 as loadable module.

Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7e1c543..fcf5b34 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -646,6 +646,7 @@ CONFIG_DRM_SUN4I=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
+CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.7.4
