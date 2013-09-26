From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Sep 2013 13:13:58 +0200
Subject: [PATCH] video: mxsfb: Add missing break
Message-ID: <1380194038-5148-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing break into the restore function.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/mxsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index d250ed0..27197a8 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -620,6 +620,7 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 		break;
 	case 3:
 		bits_per_pixel = 32;
+		break;
 	case 1:
 	default:
 		return -EINVAL;
-- 
1.8.4.rc3
