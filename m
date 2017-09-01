From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 01 Sep 2017 10:47:53 +0900
Subject: [PATCH 0/3] drm/exynos/gsc: Support the rotate hardware limits of gsc
References: <CGME20170901014757epcas1p19de712f2cea2e48b3d42b878743dd9f8@epcas1p1.samsung.com>
Message-ID: <1504230476-1878-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

The gscaler has hardware rotation limits. So this patch set support
the rotate hardware limits of gsc.

Best regards,
Hoegeun

Hoegeun Kwon (3):
  ARM: dts: exynos: Add the hardware rotation limits for gsc
  arm64: dts: exynos: Add the hardware rotation limits for gsc
  drm/exynos/gsc: Add rotation hardware limits of gscaler

 arch/arm/boot/dts/exynos5250.dtsi          |  8 ++++
 arch/arm/boot/dts/exynos5420.dtsi          |  4 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi |  6 +++
 drivers/gpu/drm/exynos/exynos_drm_gsc.c    | 63 +++++++++++++++++++-----------
 include/uapi/drm/exynos_drm.h              |  2 +
 5 files changed, 60 insertions(+), 23 deletions(-)

-- 
1.9.1
