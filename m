From: adanhawthorn@gmail.com (Nathan Howard)
Date: Fri, 17 Feb 2017 15:16:17 -0500
Subject: [PATCH 1/5] staging: bcm2835-audio: bcm2835.h: fix block comment
 warning
Message-ID: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl warning: "Block comments use * on subsequent lines."

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 36e3ef8..66af445 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -27,8 +27,8 @@
 #include <linux/workqueue.h>
 
 /*
-#define AUDIO_DEBUG_ENABLE
-#define AUDIO_VERBOSE_DEBUG_ENABLE
+ * #define AUDIO_DEBUG_ENABLE
+ * #define AUDIO_VERBOSE_DEBUG_ENABLE
  */
 
 /* Debug macros */
-- 
2.7.4
