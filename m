From: marex@denx.de (Marek Vasut)
Date: Tue,  1 Oct 2013 06:22:30 +0200
Subject: [PATCH] video: mxsfb: Add missing break
Message-ID: <1380601350-6665-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing break into the restore function.

Upstream commit: 6d0bb818041a02be682abadb3ba35ff608f7d60a

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org

---
 drivers/video/mxsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..75c5b4e 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -647,6 +647,7 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 		break;
 	case 3:
 		bits_per_pixel = 32;
+		break;
 	case 1:
 	default:
 		return -EINVAL;
-- 
1.8.4.rc3
