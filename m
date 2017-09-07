From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 07 Sep 2017 18:39:00 +0900
Subject: [PATCH v2 0/3] drm/exynos/gsc: Support the hardware rotation limits
References: <CGME20170907093912epcas2p4575c6910bfa240105083e407e1b62d10@epcas2p4.samsung.com>
Message-ID: <1504777143-29834-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

The gscaler has hardware rotation limits. So this patch set support
the rotate hardware limits of gsc.

Changes for V2:
- Added the interface info in binding document.
- Added clean name of compatible in Exynos dts.
- Added maximum supported picture size hardcoded into driver.

Best regards,
Hoegeun

Hoegeun Kwon (3):
  [media] exynos-gsc: Add compatible for Exynos 5250 and 5420 specific
    version
  ARM: dts: exynos: Add clean name of compatible.
  drm/exynos/gsc: Add hardware rotation limits

 .../devicetree/bindings/media/exynos5-gsc.txt      |   1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            | 100 +++++++++++++++------
 include/uapi/drm/exynos_drm.h                      |   2 +
 5 files changed, 80 insertions(+), 35 deletions(-)

-- 
1.9.1
