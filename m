From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  6 Jul 2018 19:50:58 +0200
Subject: [PATCH 02/17] drm/sun4i: Add R40 display engine compatible
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Message-ID: <20180706175113.26698-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R40 has versatile display pipeline. It supports two simultanious outputs
on various outputs (TVE, VGA, HDMI, MIPI DSI, LCD).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 6ddf4eaccb40..a15feb807393 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -417,6 +417,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
+	{ .compatible = "allwinner,sun8i-r40-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
 	{ }
-- 
2.18.0
