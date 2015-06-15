From: maninder1.s@samsung.com (Maninder Singh)
Date: Mon, 15 Jun 2015 08:45:44 +0530
Subject: [PATCH 1/1] arm/hw_breakpoint.c: remove unnecessary header
Message-ID: <"000001d0a719$92ad5b40$b80811c0$@s"@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Header <asm/kdebug.h> is not needed for arm,
removing the same.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm/kernel/hw_breakpoint.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
-- 
1.7.1
