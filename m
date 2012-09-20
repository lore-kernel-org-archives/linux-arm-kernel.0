From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:25 +0800
Subject: [PATCH v2 12/34] ARM: imx: remove mach/dma-mx1-mx2.h
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header mach/dma-mx1-mx2.h is used nowhere.  Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h |   10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h

diff --git a/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h b/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
deleted file mode 100644
index df5f522..0000000
--- a/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __MACH_DMA_MX1_MX2_H__
-#define __MACH_DMA_MX1_MX2_H__
-/*
- * Don't use this header in new code, it will go away when all users are
- * converted to mach/dma-v1.h
- */
-
-#include <mach/dma-v1.h>
-
-#endif /* ifndef __MACH_DMA_MX1_MX2_H__ */
-- 
1.7.9.5
