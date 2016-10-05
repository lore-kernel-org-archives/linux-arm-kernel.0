From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  5 Oct 2016 11:24:28 -0300
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable exynos-gsc driver as module
Message-ID: <1475677469-1524-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5 SoCs have a General SCALER (GSCALER) IP block that can be used
to do video streams scaling and color space conversions by hardware.
Enable support for its driver as a module so the GSCALER can be tested.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c58f6841f8aa..79c415c33f69 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -155,6 +155,7 @@ CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
+CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_DRM=y
 CONFIG_DRM_EXYNOS=y
-- 
2.7.4
