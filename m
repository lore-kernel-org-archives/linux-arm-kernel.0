From: jj@chaosbits.net (Jesper Juhl)
Date: Thu, 18 Oct 2012 21:28:10 +0200 (CEST)
Subject: [PATCH] [media] s5p-tv: don't include linux/version.h in mixer_video.c
Message-ID: <alpine.LNX.2.00.1210182125380.17217@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header is not needed, so remove it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/media/platform/s5p-tv/mixer_video.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/media/platform/s5p-tv/mixer_video.c b/drivers/media/platform/s5p-tv/mixer_video.c
index 0c1cd89..9b52f3a 100644
--- a/drivers/media/platform/s5p-tv/mixer_video.c
+++ b/drivers/media/platform/s5p-tv/mixer_video.c
@@ -19,7 +19,6 @@
 #include <linux/videodev2.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/timer.h>
 #include <media/videobuf2-dma-contig.h>
 
-- 
1.7.1


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
