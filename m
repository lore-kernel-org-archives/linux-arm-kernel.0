From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  6 Feb 2014 14:20:11 -0300
Subject: [PATCH v6 04/19] watchdog: orion: Remove unused macros
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1391707226-18258-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are not used anywhere so it's safe to remove them.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b92a991..6746033 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -33,8 +33,6 @@
 #define WDT_VAL			0x0024
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
-#define WDT_IN_USE		0
-#define WDT_OK_TO_CLOSE		1
 
 #define WDT_RESET_OUT_EN	BIT(1)
 #define WDT_INT_REQ		BIT(3)
-- 
1.8.1.5
