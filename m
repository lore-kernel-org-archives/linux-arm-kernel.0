From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu,  4 May 2017 19:48:54 +0800
Subject: [PATCH v6 09/13] drm/sun4i: Add compatible string for V3s display
 engine
In-Reply-To: <20170504114858.9008-1-icenowy@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
Message-ID: <20170504114858.9008-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features the new "Display Engine 2.0", which can now also
be driven with our subdrivers in sun4i-drm.

Add the compatible string for in sun4i_drv.c, in order to make the
display engine and its components probed.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 12ede8682b5c..dcfb241f817d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -306,6 +306,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
-- 
2.12.2
