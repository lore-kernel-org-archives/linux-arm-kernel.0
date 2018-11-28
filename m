From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Wed, 28 Nov 2018 16:32:10 +0100
Subject: [PATCH 0/2] drm/exynos: mixer: Fix color format and range setting
References: <CGME20181128153231eucas1p1bd79250c2b5170c84e5614d22070826b@eucas1p1.samsung.com>
Message-ID: <1543419132-16099-1-git-send-email-c.manszewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes the color format and color range setting
in exynos_mixer.c

Patch 1 fixes color format setting.
Patch 2 fixes color range setting.

Regards,
Chris

Christoph Manszewski (2):
  drm/exynos: mixer: Fix color format setting
  drm/exynos: mixer: Fix color range setting

 drivers/gpu/drm/exynos/exynos_mixer.c | 25 +++++++++++++------------
 drivers/gpu/drm/exynos/regs-mixer.h   |  9 +++++----
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4
