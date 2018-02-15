From: clabbe@baylibre.com (Corentin Labbe)
Date: Thu, 15 Feb 2018 08:23:15 +0000
Subject: [PATCH] drm/exynos: remove exynos_drm_rotator.h
Message-ID: <1518682995-10319-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since its inclusion in 2012 via commit bea8a429d91a ("drm/exynos: add rotator ipp driver")
this header is not used by any source files and is empty.
Lets just remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/exynos/exynos_drm_rotator.h | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_rotator.h

diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.h b/drivers/gpu/drm/exynos/exynos_drm_rotator.h
deleted file mode 100644
index 71a0b4c0c1e8..000000000000
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *
- * Authors:
- *	YoungJun Cho <yj44.cho@samsung.com>
- *	Eunchul Kim <chulspro.kim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef	_EXYNOS_DRM_ROTATOR_H_
-#define	_EXYNOS_DRM_ROTATOR_H_
-
-/* TODO */
-
-#endif
-- 
2.13.6
