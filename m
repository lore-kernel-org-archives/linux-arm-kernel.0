From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Fri,  5 Oct 2012 12:16:09 +0200
Subject: [RFC PATCH v3 4/4] watchdog: WatchDog Timer Driver Core: fix comment
In-Reply-To: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349432169-13006-5-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 include/linux/watchdog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d09dda7..9e6a8f2 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -175,7 +175,7 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 	return wdd->driver_data;
 }
 
-/* drivers/watchdog/core/watchdog_core.c */
+/* drivers/watchdog/watchdog_core.c */
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 extern void watchdog_init_timeout(struct watchdog_device *wdd,
-- 
1.7.11.3
