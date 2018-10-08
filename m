From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Mon,  8 Oct 2018 11:33:00 +0200
Subject: [PATCH 0/2] drm/exynos: fimd: Add properties
In-Reply-To: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
References: <20181003094053eucas1p107c7a8a60c48dd68625fdaa223ef1996~aD9p3GwpI1866618666eucas1p1B@eucas1p1.samsung.com>
 <CGME20181008093326eucas1p24634c69cc44d324b377755af1f761241@eucas1p2.samsung.com>
Message-ID: <20181008093326eucas1p24634c69cc44d324b377755af1f761241~bmFkaQ-gm0356403564eucas1p2g@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties
to exynos_drm_fimd.

Patch 1 add window alpha property.
Patch 2 add pixel blend mode property.

Regards,
Chris


Christoph Manszewski (2):
  drm/exynos: fimd: Make plane alpha configurable
  drm/exynos: fimd: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 87 ++++++++++++++++++++++++--------
 include/video/samsung_fimd.h             |  2 +
 2 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.7.4
