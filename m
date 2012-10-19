From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 19 Oct 2012 15:30:27 +0200
Subject: [PATCH 2/2] ASoC: Ux500: Fixup compile error
In-Reply-To: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350653427-28611-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The below commit introduced a compile error for a missing include file.
ASoC: ux500_msp_i2s: better use devm functions and fix error return code

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index e6ff328..ba15351 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -18,6 +18,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/of.h>
 
 #include <mach/hardware.h>
-- 
1.7.10
