From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:30 +0900
Subject: [PATCH 08/14] ARM: shmobile: Remove include <mach/hardware.h>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <5717bcf3712fc30c8b4b7f714ebbf0bfcb922bb6.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when no one is using this file, remove <mach/hardware.h>.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/hardware.h | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/hardware.h

diff --git a/arch/arm/mach-shmobile/include/mach/hardware.h b/arch/arm/mach-shmobile/include/mach/hardware.h
deleted file mode 100644
index 99264a5..0000000
--- a/arch/arm/mach-shmobile/include/mach/hardware.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASM_MACH_HARDWARE_H
-#define __ASM_MACH_HARDWARE_H
-
-#endif /* __ASM_MACH_HARDWARE_H */
-- 
1.8.3.2
