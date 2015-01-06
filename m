From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Tue,  6 Jan 2015 18:15:01 +0530
Subject: [PATCH] video: vt8500lcdfb: remove unneeded continue
Message-ID: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

continue is not needed at the end of a for loop

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/vt8500lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index ffaf29e..6716bf5 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -115,7 +115,6 @@ static int vt8500lcd_set_par(struct fb_info *info)
 	for (i = 0; i < 8; i++) {
 		if (bpp_values[i] == info->var.bits_per_pixel) {
 			reg_bpp = i;
-			continue;
 		}
 	}
 
-- 
1.8.1.2
