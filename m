From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:54 +0200
Subject: [PATCH v11 1/8] ASoC: imx-pcm-dma: Add missing include
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index aa6de5c..4dc1296 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
+#include <linux/module.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
1.8.4.rc3
