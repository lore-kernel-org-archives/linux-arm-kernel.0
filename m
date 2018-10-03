From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed,  3 Oct 2018 11:40:42 +0200
Subject: [PATCH 0/2] drm/exynos: decon: Add properties
References: <CGME20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996@eucas1p1.samsung.com>
Message-ID: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties
to exynos5433_drm_decon.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 51 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       |  5 +++
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.4
