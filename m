From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Apr 2018 12:35:36 +0200
Subject: [PATCH 2/3] ARM: exynos_defconfig: enable S6E63J0X03 panel driver
In-Reply-To: <20180416103537.29518-1-m.szyprowski@samsung.com>
References: <20180416103537.29518-1-m.szyprowski@samsung.com>
 <CGME20180416103544eucas1p232a511004fcda0ee20c94153caa1bff7@eucas1p2.samsung.com>
Message-ID: <20180416103537.29518-2-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Samsung S6E63J0X03 DSI panel driver to enable support for display
panel on Exynos3250-based Samsung Rinato board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 629189c62fd1..85b2369d6b20 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -208,6 +208,7 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
+CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
 CONFIG_DRM_NXP_PTN3460=y
 CONFIG_DRM_PARADE_PS8622=y
-- 
2.15.0
