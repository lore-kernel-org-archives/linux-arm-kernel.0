From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Tue, 07 Aug 2012 18:04:32 +0530
Subject: [PATCH V4 2/2] include/video: Add register offsets for FIMD version 8
In-Reply-To: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1344342872-7904-3-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FIMD version 8 has VIDTCON and VIDCON registers at different offsets
from the previous versions. Hence, adding the macros.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 include/video/samsung_fimd.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index e979f42..7ae6c07 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -524,3 +524,10 @@
  * 1110		-none-	 -none-	  -none-   -none-    -none-
  * 1111		-none-	 -none-   -none-   -none-    -none-
 */
+
+/* FIMD Version 8 register offset definitions */
+#define FIMD_V8_VIDTCON0	(0x20010)
+#define FIMD_V8_VIDTCON1	(0x20014)
+#define FIMD_V8_VIDTCON2	(0x20018)
+#define FIMD_V8_VIDTCON3	(0x2001C)
+#define FIMD_V8_VIDCON1		(0x20004)
-- 
1.7.0.4
