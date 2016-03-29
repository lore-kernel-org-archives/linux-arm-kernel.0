From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Mar 2016 21:28:54 -0400
Subject: [PATCH 0/3] drm/exynos: Kconfig dependency fixes
Message-ID: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Inki,

This patch series contains some fixes for the Kconfig symbol dependencies
of the Exynos DRM driver. They make sure that the Exynos DRM components
and the media platform drivers that makes use of the same HW IP block are
not enabled at the same time.

Best regards,
Javier


Javier Martinez Canillas (3):
  drm/exynos: Use VIDEO_SAMSUNG_S5P_G2D=n as G2D Kconfig dependency
  drm/exynos: Use VIDEO_SAMSUNG_EXYNOS_GSC=n as GSC Kconfig dependency
  drm/exynos: Make DRM_EXYNOS_FIMC depend on VIDEO_S5P_FIMC=n

 drivers/gpu/drm/exynos/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.5.0
