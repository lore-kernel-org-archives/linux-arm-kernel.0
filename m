From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:45 +0800
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded mach/hardware.h inclusion
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/fsl/imx-ssi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index e6a17ba..1a28f15 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -48,7 +48,6 @@
 #include <sound/soc.h>
 
 #include <linux/platform_data/asoc-imx-ssi.h>
-#include <mach/hardware.h>
 
 #include "imx-ssi.h"
 
-- 
1.7.9.5
