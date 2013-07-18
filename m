From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Jul 2013 19:39:21 -0700
Subject: [PATCH 3/3] ARM: Remove temporary sched_clock.h header
In-Reply-To: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
References: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374115161-675-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header file is no longer needed now that the ARM sched_clock
framework is generic and all users have moved to linux/sched_clock.h
instead of asm/sched_clock.h. Remove it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/sched_clock.h | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 arch/arm/include/asm/sched_clock.h

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
deleted file mode 100644
index 2389b71..0000000
--- a/arch/arm/include/asm/sched_clock.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* You shouldn't include this file. Use linux/sched_clock.h instead.
- * Temporary file until all asm/sched_clock.h users are gone
- */
-#include <linux/sched_clock.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
