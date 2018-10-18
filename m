From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 18 Oct 2018 11:36:08 +0200
Subject: [PATCH v2 0/2] drm/exynos: decon: Add properties
References: <CGME20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc@eucas1p1.samsung.com>
Message-ID: <20181018093633eucas1p156cb1309c45885a86d922bc1841dadfc~eqlJTAnxg2418824188eucas1p12@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties
to exynos5433_drm_decon.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris

Changes in v2:
 - add premultiplied pixel blend mode (i.e. make it functional),
 - correct minor issues from v1,
 - refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 83 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 103 insertions(+), 2 deletions(-)

-- 
2.7.4
