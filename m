From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 25 Oct 2018 18:21:51 +0200
Subject: [PATCH v4 0/2] drm/exynos: decon: Add properties
References: <CGME20181025162201eucas1p1033325147e317799e7c174345c9ab333@eucas1p1.samsung.com>
Message-ID: <20181025162201eucas1p1033325147e317799e7c174345c9ab333~g5oKoWGPR1757217572eucas1p1Y@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties
to exynos5433_drm_decon.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris

Changes in v4:
- set blend equation for DRM_MODE_BLEND_PIXEL_NONE explicitly,

Changes in v3: 
- fix compilation error,

Changes in v2: 
- add premultiplied pixel blend mode (i.e. make it functional),
- correct minor issues from v1, 
- refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 82 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.7.4
