From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Mon, 19 Nov 2012 15:10:43 +0100
Subject: [PATCH v5 8/8] watchdog: WatchDog Timer Driver Core - fix comment
In-Reply-To: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1353334243-16703-9-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 include/linux/watchdog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 5cff9d6..04ef8bd 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -129,7 +129,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
-/* drivers/watchdog/core/watchdog_core.c */
+/* drivers/watchdog/watchdog_core.c */
 extern void watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int parm_timeout,
 				  struct device_node *node);
-- 
1.8.0
