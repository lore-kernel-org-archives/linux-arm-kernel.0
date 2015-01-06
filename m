From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Jan 2015 12:08:45 +0100
Subject: [RESEND PATCH v5 3/3] drm: panel: simple-panel: add bus format
 information for foxlink panel
In-Reply-To: <1420542525-13507-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1420542525-13507-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1420542525-13507-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Foxlink's fl500wvr00-a0t supports RGB888 format.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4504018..6049d24 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -563,6 +563,7 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 		.width = 108,
 		.height = 65,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
 static const struct drm_display_mode hannstar_hsd070pww1_mode = {
-- 
1.9.1
