From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 12 Jun 2012 12:37:39 +0200
Subject: [PATCH] ARM: remove old SA-1111.h
Message-ID: <1339497459.30984.118.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All (in tree) users of old mach/SA-1111.h were already updated to
include asm/hardware/sa1111.h in v2.6.12-rc2. The old header can safely
be removed now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only by "git grepping" the (history of) the tree.

 arch/arm/mach-sa1100/include/mach/SA-1111.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1111.h

diff --git a/arch/arm/mach-sa1100/include/mach/SA-1111.h b/arch/arm/mach-sa1100/include/mach/SA-1111.h
deleted file mode 100644
index c38f609..0000000
--- a/arch/arm/mach-sa1100/include/mach/SA-1111.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * Moved to new location
- */
-#warning using old SA-1111.h - update to <asm/hardware/sa1111.h>
-#include <asm/hardware/sa1111.h>
-- 
1.7.7.6
