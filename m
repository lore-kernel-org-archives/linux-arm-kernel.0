From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 19:09:46 +0800
Subject: [PATCH v14 02/17] drm/exynos: dp: rename implementation specific
 driver part
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455534586-1534-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

The core functionality now resides in the generic bridge part so the
exynos-specific implementation details can get a more suitable nameing.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/exynos/Makefile                          | 2 +-
 drivers/gpu/drm/exynos/{exynos_dp_core.c => exynos_dp.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/gpu/drm/exynos/{exynos_dp_core.c => exynos_dp.c} (100%)

diff --git a/drivers/gpu/drm/exynos/Makefile b/drivers/gpu/drm/exynos/Makefile
index 18244c5..533151b 100644
--- a/drivers/gpu/drm/exynos/Makefile
+++ b/drivers/gpu/drm/exynos/Makefile
@@ -13,7 +13,7 @@ exynosdrm-$(CONFIG_DRM_EXYNOS5433_DECON)	+= exynos5433_drm_decon.o
 exynosdrm-$(CONFIG_DRM_EXYNOS7_DECON)	+= exynos7_drm_decon.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_DPI)	+= exynos_drm_dpi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_DSI)	+= exynos_drm_dsi.o
-exynosdrm-$(CONFIG_DRM_EXYNOS_DP)	+= exynos_dp_core.o
+exynosdrm-$(CONFIG_DRM_EXYNOS_DP)	+= exynos_dp.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_MIXER)	+= exynos_mixer.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_HDMI)	+= exynos_hdmi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_VIDI)	+= exynos_drm_vidi.o
diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp.c
similarity index 100%
rename from drivers/gpu/drm/exynos/exynos_dp_core.c
rename to drivers/gpu/drm/exynos/exynos_dp.c
-- 
1.9.1
