From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Apr 2016 03:20:04 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable new Rockchip
 display-controller drivers
In-Reply-To: <10307860.X4SVE35FiH@phil>
References: <10307860.X4SVE35FiH@phil>
Message-ID: <4195825.sRqdISUi1R@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three types of display controller-drivers where added recently. The
Analogix Displayport variant and Designware MIPI DSI used for example
on the rk3288 as well as the Innosilicon HDMI controller used on the
rk3036.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 66d15ed..b4489e0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -532,7 +532,10 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_ROCKCHIP=m
+CONFIG_ROCKCHIP_ANALOGIX_DP=m
 CONFIG_ROCKCHIP_DW_HDMI=m
+CONFIG_ROCKCHIP_DW_MIPI_DSI=m
+CONFIG_ROCKCHIP_INNO_HDMI=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
-- 
2.6.4
