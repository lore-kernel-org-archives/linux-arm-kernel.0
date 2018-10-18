From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Thu, 18 Oct 2018 14:51:45 +0200
Subject: [PATCH v3 0/2] drm/exynos: decon: Add properties
References: <CGME20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032@eucas1p1.samsung.com>
Message-ID: <20181018125205eucas1p1d1883ebf537df8268e1e0ce2bc92f032~etP3p4mTk0073500735eucas1p1P@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

In patchset v2, accidentally wrong patches were sent - sorry for that.

Regards,
Chris

Changes in v3:
 - fix compilation error,

Changes in v2: 
 - add premultiplied pixel blend mode (i.e. make it functional),
 - correct minor issues from v1, 
 - refactor code in order to adapt to above changes.

Christoph Manszewski (2):
  drm/exynos: decon: Make plane alpha configurable
  drm/exynos: decon: Make pixel blend mode configurable

 drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 84 ++++++++++++++++++++++++++-
 drivers/gpu/drm/exynos/regs-decon5433.h       | 22 +++++++
 2 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.7.4
