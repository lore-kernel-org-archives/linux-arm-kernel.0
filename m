From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Fri, 20 Apr 2018 18:32:14 +0200
Subject: [PATCH 0/2] drm/exynos: fimd: Add support for S5PV210
Message-ID: <1524241936-10295-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series compose of 2 patches.

First patch, adding support for S5PV210 FIMD variant to Exynos driver.
Compatible for this soc was already existing in documentation.

Second patch, brings back possibility to use drivers depending on
DRM_EXYNOS, on Samsung S5PV210/S5PC110 series based systems.

Both patches has been tested on (not yet mainlined), an S5PV210 based
Samsung Galaxy S (i9000) phone.

Pawe? Chmiel (1):
  drm/exynos: Allow DRM_EXYNOS on s5pv210.

Tomasz Figa (1):
  drm/exynos: fimd: Add support for S5PV210 FIMD variant

 drivers/gpu/drm/exynos/Kconfig           | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.7.4
