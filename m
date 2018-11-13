From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 17:45:34 +0530
Subject: [PATCH v6 3/4] arm64: defconfig: Enable DRM_SUN8I_DW_HDMI
In-Reply-To: <20181113121535.24137-1-jagan@amarulasolutions.com>
References: <20181113121535.24137-1-jagan@amarulasolutions.com>
Message-ID: <20181113121535.24137-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner DesignWare HDMI is needed for HDMI support
in ARM64 Allwinner SoC's, build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- none
Changes for v5:
- Enable it on defconfig
Changes for v4:
- none
Changes for v3:
- skip SUN8I enablement, since it built statically for arm32
Changes for v2:
- Enable for SUN8I

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7f271178d421..cb614bd70716 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -447,6 +447,7 @@ CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_SUN8I_MIXER=m
+CONFIG_DRM_SUN8I_DW_HDMI=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.18.0.321.gffc6fa0e3
