From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat, 14 Jun 2014 18:23:30 +0200
Subject: [PATCH v3 08/19] clocksource: shmobile: Remove unused sh_timer_config
 members
In-Reply-To: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1402763021-4067-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name, channel_offset, timer_bit, clockevent_rating and
clocksource_rating members are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/sh_timer.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/sh_timer.h b/include/linux/sh_timer.h
index 8e1e036..64638b0 100644
--- a/include/linux/sh_timer.h
+++ b/include/linux/sh_timer.h
@@ -2,11 +2,6 @@
 #define __SH_TIMER_H__
 
 struct sh_timer_config {
-	char *name;
-	long channel_offset;
-	int timer_bit;
-	unsigned long clockevent_rating;
-	unsigned long clocksource_rating;
 	unsigned int channels_mask;
 };
 
-- 
1.8.5.5
