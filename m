From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  1 Mar 2018 22:34:33 +0100
Subject: [PATCH v3 07/16] drm/sun4i: Add support for H3 display engine
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Message-ID: <20180301213442.16677-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 display engine has two mixers which are connected to HDMI and TV
output.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 3957c2ff6870..a0f43b81c64c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -359,6 +359,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun7i-a20-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
+	{ .compatible = "allwinner,sun8i-h3-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
-- 
2.16.2
