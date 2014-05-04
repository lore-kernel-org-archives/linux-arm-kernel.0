From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun,  4 May 2014 23:26:17 +0800
Subject: [PATCH 0/4] drm/exynos/mixer: small cleanups
Message-ID: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't actually have a way of testing the video processor changes, but they
seem correct from looking at the code.  Hopefully someone has a way of testing
them.

Daniel Kurtz (4):
  drm/exynos/mixer: move format definitions to regs-mixer
  drm/exynos/mixer: use MXR_GRP_SXY_SY
  drm/exynos/mixer: planes are not disabled by setting dma_addr to zero
  drm/exynos/mixer: add support for NV21

 drivers/gpu/drm/exynos/exynos_drm_plane.c |  1 +
 drivers/gpu/drm/exynos/exynos_mixer.c     | 54 +++++++++++--------------------
 drivers/gpu/drm/exynos/regs-mixer.h       |  4 +++
 3 files changed, 23 insertions(+), 36 deletions(-)

-- 
1.9.1.423.g4596e3a
