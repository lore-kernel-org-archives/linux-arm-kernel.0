From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 May 2016 17:07:28 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable Exynos MFC driver as
 module
In-Reply-To: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
References: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1462914448-24480-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos SoCs have a Multi Format Video Hardware Codec (MFC) IP block that
can be used to {en,de}code video streams by hardware. Enable support for
its driver as a module so the MFC can be tested.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

This patch depends on https://patchwork.kernel.org/patch/8970711/

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2ba3f0cd2261..8086e9e13ff6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -534,6 +534,7 @@ CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
 CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
+CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
-- 
2.5.5
