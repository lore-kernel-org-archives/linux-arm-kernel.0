From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:42 +0530
Subject: [PATCH 05/21] drm/sun4i: Add support for A64 display engine
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-6-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64 display engine has two mixers which are connected to
LVDS/RGB/MIPI-DSI and HDMI output through tcon0 and tcon1.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 50d19605c38f..c84102a750f8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -368,6 +368,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-h3-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
+	{ .compatible = "allwinner,sun50i-a64-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
-- 
2.14.3
