From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Fri, 21 Sep 2018 14:24:35 +0200
Subject: [PATCH 0/3] drm/exynos: mixer: Cleanup and add properties 
References: <CGME20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b@eucas1p1.samsung.com>
Message-ID: <20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b~WaefRJq8x0332003320eucas1p1W@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds two new configurable properties to exynos_mixer,
and introduces use of helper functions in exynos_drm_plane_reset.

Patch 1 incorporate use of helper functions, to correctly initialize
parameters used in following patches.
Patch 2 add pixel blend mode property.
Patch 3 add window alpha property.

Regards,
Chris

Christoph Manszewski (3):
  drm/exynos: drm_plane: Correct exynos_drm_plane_reset
  drm/exynos: mixer: Make pixel blend mode configurable
  drm/exynos: mixer: Make plane alpha configurable

 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 ++
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 16 ++++++---
 drivers/gpu/drm/exynos/exynos_mixer.c     | 56 +++++++++++++++++++++----------
 drivers/gpu/drm/exynos/regs-mixer.h       |  5 ++-
 4 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.7.4
