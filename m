From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 May 2016 17:07:27 -0400
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable MFC driver as module
Message-ID: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos SoCs have a Multi Format Video Hardware Codec (MFC) IP block that
can be used to {en,de}code video streams by hardware. Enable support for
its driver as a module so the MFC can be tested.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

This patch depends on https://patchwork.kernel.org/patch/8970731/

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 0600818f0f2a..007c8eca407e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -155,6 +155,7 @@ CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
 CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
+CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_DRM=y
 CONFIG_DRM_NXP_PTN3460=y
 CONFIG_DRM_PARADE_PS8622=y
-- 
2.5.5
