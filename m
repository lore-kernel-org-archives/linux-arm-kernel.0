From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:45 +0200
Subject: [PATCH v3 01/15] ASoC: imx-ssi: Fix includes
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-ssi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index d8063c2..bb6b3db 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -187,6 +187,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-imx.h>
+#include <sound/dmaengine_pcm.h>
 #include "imx-pcm.h"
 
 struct imx_ssi {
-- 
1.8.1.5
