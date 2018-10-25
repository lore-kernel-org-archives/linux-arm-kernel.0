From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 25 Oct 2018 17:23:48 +0200
Subject: [PATCH v2 0/2] drm/exynos: fimd: Add properties
References: <CGME20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7@eucas1p2.samsung.com>
Message-ID: <20181025152409eucas1p22b08bb21ed0de710560ec0ced77958a7~g41o9kz2u0946109461eucas1p2r@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties
to exynos_drm_fimd.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode propery.

Regards,
Chris

Changes in v2:
 - add premultiplied pixel blend mode (i. e. make it functional),
 - correct issues from v1,
 - refactor code in order to adapt above changes.

Christoph Manszewski (2):
  drm/exynos: fimd: Make plane alpha configurable
  drm/exynos: fimd: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 123 +++++++++++++++++++++++++------
 include/video/samsung_fimd.h             |  10 +++
 2 files changed, 110 insertions(+), 23 deletions(-)

-- 
2.7.4
