From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 27 Nov 2014 11:15:01 +0800
Subject: [PATCH] media: v4l2-image-sizes.h: correct the SVGA height definition
Message-ID: <1417058101-2798-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SVGA height should be 600 not 680.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
Hi, Mauro

There a typo in my previous patch, so this patch is the fix for that.
Sorry for the incovenience.

Best Regards,
Josh Wu

 include/media/v4l2-image-sizes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/v4l2-image-sizes.h b/include/media/v4l2-image-sizes.h
index c70c917..a07d7a6 100644
--- a/include/media/v4l2-image-sizes.h
+++ b/include/media/v4l2-image-sizes.h
@@ -26,7 +26,7 @@
 #define QVGA_HEIGHT	240
 
 #define SVGA_WIDTH	800
-#define SVGA_HEIGHT	680
+#define SVGA_HEIGHT	600
 
 #define SXGA_WIDTH	1280
 #define SXGA_HEIGHT	1024
-- 
1.9.1
