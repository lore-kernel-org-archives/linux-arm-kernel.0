From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 24 Oct 2017 10:48:12 +0200
Subject: [PATCH 0/3] GPU-DRM-Exynos: Fine-tuning for six function
 implementations
Message-ID: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Oct 2017 10:34:56 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use common error handling code in exynos_dsi_enable()
  Use common error handling code in exynos_drm_gem_init()
  Fix typos in five comment lines

 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 12 +++++++-----
 drivers/gpu/drm/exynos/exynos_drm_fimc.c |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c  |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c  | 16 +++++++++-------
 drivers/gpu/drm/exynos/exynos_drm_ipp.c  |  2 +-
 6 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.14.2
