From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 00:01:43 +0800
Subject: [PATCH v2 05/11] drm: sun4i: add compatible for H3 display engine
In-Reply-To: <20170604160149.30230-1-icenowy@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
Message-ID: <20170604160149.30230-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible string for H3 display engine in sun4i_drv code.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 775eee82d8a9..2003507b41a6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -355,6 +355,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{ .compatible = "allwinner,sun8i-h3-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
-- 
2.12.2
