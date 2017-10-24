From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 24 Oct 2017 10:52:02 +0200
Subject: [PATCH 3/3] drm/exynos: Fix typos in five comment lines
In-Reply-To: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
References: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
Message-ID: <fe7f02cd-4424-84b3-9c9e-665a5d60e325@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Oct 2017 10:20:20 +0200

The script "checkpatch.pl" pointed misspelled words out.
Thus fix the affected places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c  | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index ba5fb49c5491..08cdfe7e82a0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -841,7 +841,7 @@ static int exynos_dsi_init_link(struct exynos_dsi *dsi)
 	 * Use non-continuous clock mode if the periparal wants and
 	 * host controller supports
 	 *
-	 * In non-continous clock mode, host controller will turn off
+	 * In non-continuous clock mode, host controller will turn off
 	 * the HS clock between high-speed transmissions to reduce
 	 * power consumption.
 	 */
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 5b18b5c5fdf2..a14738e81a5a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -1437,7 +1437,7 @@ static int fimc_ippdrv_start(struct device *dev, enum drm_exynos_ipp_cmd cmd)
 		return ret;
 	}
 
-	/* If set ture, we can save jpeg about screen */
+	/* If set true, we can save jpeg about screen */
 	fimc_handle_jpeg(ctx, false);
 	fimc_set_scaler(ctx, &ctx->sc);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index d42ae2bc3e56..50a4c3435cd0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -594,7 +594,7 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 	/*
 	 * Setting dma-burst to 16Word causes permanent tearing for very small
 	 * buffers, e.g. cursor buffer. Burst Mode switching which based on
-	 * plane size is not recommended as plane size varies alot towards the
+	 * plane size is not recommended as plane size varies a lot towards the
 	 * end of the screen and rapid movement causes unstable DMA, but it is
 	 * still better to change dma-burst than displaying garbage.
 	 */
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 2b8bf2dd6387..f4de1f3d37a3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -29,7 +29,7 @@
 #define G2D_HW_MAJOR_VER		4
 #define G2D_HW_MINOR_VER		1
 
-/* vaild register range set from user: 0x0104 ~ 0x0880 */
+/* valid register range set from user: 0x0104 ~ 0x0880 */
 #define G2D_VALID_START			0x0104
 #define G2D_VALID_END			0x0880
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 3edda18cc2d2..2feeba705c1f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -1747,7 +1747,7 @@ static int ipp_probe(struct platform_device *pdev)
 		goto err_event_workq;
 	}
 
-	/* set sub driver informations */
+	/* set sub driver information */
 	subdrv = &ctx->subdrv;
 	subdrv->dev = dev;
 	subdrv->probe = ipp_subdrv_probe;
-- 
2.14.2
