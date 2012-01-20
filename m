From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:01 -0600
Subject: [PATCH v2 03/13] ARM: remove mc146818rtc.h from time.c
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

mc146818rtc.h is not needed in time.c, so remove it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/time.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 8c57dd3..6095517 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -25,8 +25,6 @@
 #include <linux/timer.h>
 #include <linux/irq.h>
 
-#include <linux/mc146818rtc.h>
-
 #include <asm/leds.h>
 #include <asm/thread_info.h>
 #include <asm/sched_clock.h>
-- 
1.7.5.4
