From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 22 Aug 2013 10:37:20 +0800
Subject: [PATCH -next] ASoC: mmp-pcm: remove duplicated include from mmp-pcm.c
Message-ID: <CAPgLHd9Eey5pbDjQmSquHvJY4zpDBDtp9brzWn-s5P6kaKmvpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/pxa/mmp-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 9a97843..8235e23 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -17,7 +17,6 @@
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/platform_data/mmp_audio.h>
-#include <linux/dmaengine.h>
 
 #include <sound/pxa2xx-lib.h>
 #include <sound/core.h>
