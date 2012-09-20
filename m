From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:30 +0800
Subject: [PATCH v2 17/34] video: mx3fb: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-18-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev at vger.kernel.org
---
 drivers/video/mx3fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 3b63ad8..fc50320 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -29,7 +29,6 @@
 #include <linux/dma/ipu-dma.h>
 
 #include <linux/platform_data/dma-imx.h>
-#include <mach/hardware.h>
 #include <linux/platform_data/video-mx3fb.h>
 
 #include <asm/io.h>
-- 
1.7.9.5
