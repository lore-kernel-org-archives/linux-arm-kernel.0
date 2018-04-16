From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Apr 2018 12:35:37 +0200
Subject: [PATCH 3/3] ARM: multi_v7_config: enable S6E63J0X03 panel driver
In-Reply-To: <20180416103537.29518-1-m.szyprowski@samsung.com>
References: <20180416103537.29518-1-m.szyprowski@samsung.com>
 <CGME20180416103544eucas1p2cfe8f3c07710237706da176107e839fd@eucas1p2.samsung.com>
Message-ID: <20180416103537.29518-3-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a module with Samsung S6E63J0X03 DSI panel driver to enable support
for display panel on Exynos3250-based Samsung Rinato board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96d4c09..b9e68ab01fa2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -638,6 +638,7 @@ CONFIG_DRM_SUN4I=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
+CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_SII9234=m
-- 
2.15.0
