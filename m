From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  4 Sep 2018 22:06:07 +0530
Subject: [PATCH v4 2/4] arm64: defconfig: Enable CONFIG_DRM_SUN4I
In-Reply-To: <20180904163609.10171-1-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
Message-ID: <20180904163609.10171-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DRM Support for Allwinner Display Engine, built as a module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3, v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..4919e4577548 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -433,6 +433,7 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
+CONFIG_DRM_SUN4I=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.18.0.321.gffc6fa0e3
