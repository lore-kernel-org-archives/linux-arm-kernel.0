From: peda@axentia.se (Peter Rosin)
Date: Mon,  9 Apr 2018 12:59:18 +0200
Subject: [PATCH 5/5] drm/atmel-hlcdc: fix broken release date
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
Message-ID: <20180409105918.20792-6-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bump the minor version while at it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index b411038890a9..aec0e0e05edb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -782,9 +782,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.fops = &fops,
 	.name = "atmel-hlcdc",
 	.desc = "Atmel HLCD Controller DRM",
-	.date = "20141504",
+	.date = "20180409",
 	.major = 1,
-	.minor = 0,
+	.minor = 1,
 };
 
 static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
-- 
2.11.0
