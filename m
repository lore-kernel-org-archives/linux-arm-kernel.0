From: maninder1.s@samsung.com (Maninder Singh)
Date: Thu, 11 Jun 2015 16:09:58 +0530
Subject: [PATCH v2] arm:arm64/hw_breakpoint.c: Remove unnecessary header
Message-ID: <"000a01d0a433$033bc340$09b349c0$@s"@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Header <asm/kdebug.h> is not needed in hw_breakpoint.c 
for arm as well as arm64.
Removing the same.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm/kernel/hw_breakpoint.c   |    1 -
 arch/arm64/kernel/hw_breakpoint.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c
b/arch/arm/kernel/hw_breakpoint.c
index dc7d0a9..6284779 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -35,7 +35,6 @@
 #include <asm/cputype.h>
 #include <asm/current.h>
 #include <asm/hw_breakpoint.h>
-#include <asm/kdebug.h>
 #include <asm/traps.h>
 
 /* Breakpoint currently in use for each BRP. */
diff --git a/arch/arm64/kernel/hw_breakpoint.c
b/arch/arm64/kernel/hw_breakpoint.c
index e7d934d..7a1a5da 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -31,7 +31,6 @@
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
-#include <asm/kdebug.h>
 #include <asm/traps.h>
 #include <asm/cputype.h>
 #include <asm/system_misc.h>
-- 
1.7.1
