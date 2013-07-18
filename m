From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Jul 2013 19:39:20 -0700
Subject: [PATCH 2/3] ARM: clps711x: Use linux/sched_clock.h
In-Reply-To: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
References: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374115161-675-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sched_clock.h include is under include/linux now.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-clps711x/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 4ca2f3c..134641d 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -29,12 +29,12 @@
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/clk-provider.h>
+#include <linux/sched_clock.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/sched_clock.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
