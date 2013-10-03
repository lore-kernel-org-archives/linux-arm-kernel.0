From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  3 Oct 2013 12:49:43 -0700
Subject: [PATCH 2/2] ARM: Remove temporary sched_clock.h header
In-Reply-To: <1380829783-876-1-git-send-email-sboyd@codeaurora.org>
References: <1380829783-876-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1380829783-876-2-git-send-email-sboyd@codeaurora.org>
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
