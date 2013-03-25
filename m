From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:11:39 +0800
Subject: [PATCH] ARM: mxs: remove unneeded mach-types.h inclusion
Message-ID: <1364224299-28255-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unneeded mach-types.h inclusion from mxs.h, which is a
leftover from commit 845da6b (ARM: mxs: detect SoC by checking CHIPID
register).

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/mxs.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 7d4fb6d..a9be80a 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -22,7 +22,6 @@
 #ifndef __ASSEMBLER__
 #include <linux/io.h>
 #endif
-#include <asm/mach-types.h>
 #include <mach/digctl.h>
 #include <mach/hardware.h>
 
-- 
1.7.9.5
