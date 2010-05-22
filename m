From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Sun, 23 May 2010 01:12:34 +0800
Subject: [PATCH 07/12] arm: remove duplicated #include
Message-ID: <1274548354-2088-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/plat-nomadik/include/plat/ste_dma40.h

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/plat-nomadik/include/plat/ste_dma40.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ste_dma40.h b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
index 4d12ea4..0aff0fe 100644
--- a/arch/arm/plat-nomadik/include/plat/ste_dma40.h
+++ b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
@@ -14,7 +14,6 @@
 #include <linux/dmaengine.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
-#include <linux/dmaengine.h>
 
 /* dev types for memcpy */
 #define STEDMA40_DEV_DST_MEMORY (-1)
-- 
1.6.1.3
