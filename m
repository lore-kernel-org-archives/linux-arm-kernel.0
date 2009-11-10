From: njun@marvell.com (Jun Nie)
Date: Tue, 10 Nov 2009 15:11:36 +0800
Subject: [PATCH] pxa: delete redundant  vsync/hsync revert flag
      var.sync can cover its function
Message-ID: <mailman.8.1257840748.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jun Nie <njun@marvell.com>
---
 include/video/pxa168fb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 024767c..efbe469 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -142,8 +142,6 @@ struct pxa168fb_mach_info {
 	unsigned	invert_composite_blank:1;
 	unsigned	invert_pix_val_ena:1;
 	unsigned	invert_pixclock:1;
-	unsigned	invert_vsync:1;
-	unsigned	invert_hsync:1;
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
-- 
1.5.4.3
