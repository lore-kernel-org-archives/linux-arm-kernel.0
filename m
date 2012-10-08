From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 8 Oct 2012 20:32:48 +0800
Subject: [PATCH] [media] s5p-tv: remove unused including <linux/version.h>
Message-ID: <CAPgLHd-0c4D0cSVQBZA=bbaDvcu4yHBj_2DPPGrQMKQZxxGqBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove including <linux/version.h> that don't need it.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/media/platform/s5p-tv/mixer_video.c | 1 -
 1 file changed, 1 deletion(-)

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
 
