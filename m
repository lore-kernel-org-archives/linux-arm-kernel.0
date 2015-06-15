From: maninder1.s@samsung.com (Maninder Singh)
Date: Mon, 15 Jun 2015 08:46:53 +0530
Subject: [PATCH 1/1] arm64/hw_breakpoint.c: remove unnecessary header
Message-ID: <"000101d0a719$bcab7a80$36026f80$@s"@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Header <asm/kdebug.h> is not needed for arm64,
removing the same.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm64/kernel/hw_breakpoint.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
