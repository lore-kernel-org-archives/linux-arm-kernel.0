From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 21:16:58 +0200
Subject: [PATCH 3/4] ARM: exynos_defconfig: Disable STMicroelectronics DRM
 drivers
In-Reply-To: <20170621191659.10929-1-krzk@kernel.org>
References: <20170621191659.10929-1-krzk@kernel.org>
Message-ID: <20170621191659.10929-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRM_STM is selected by default but it is useless for Exynos platform.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index dfe43acec129..71b8dbcc1d65 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -203,6 +203,7 @@ CONFIG_DRM_EXYNOS_MIXER=y
 CONFIG_DRM_EXYNOS_DPI=y
 CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
+# CONFIG_DRM_STM is not set
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
-- 
2.9.3
