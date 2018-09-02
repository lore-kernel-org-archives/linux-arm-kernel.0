From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:26 +0200
Subject: [PATCH 10/27] drm/sun4i: Add compatible for H6 display engine
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Message-ID: <20180902072643.4917-11-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H6 is first Allwinner SoC which supports 10 bit colors, HDR and AFBC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index dd19d674055c..e5731d092e1a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -410,6 +410,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun4i-a10-display-engine" },
+	{ .compatible = "allwinner,sun50i-h6-display-engine" },
 	{ .compatible = "allwinner,sun5i-a10s-display-engine" },
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
-- 
2.18.0
