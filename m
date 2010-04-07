From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed,  7 Apr 2010 15:21:42 -0700
Subject: [PATCH] ARM: LPC32XX: pm.c - added needed include for slab.h
Message-ID: <1270678902-25509-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added slab.h include recently needed for kmalloc/kfree
See commit 5a0e3ad6af8660be21ca98a971cd00f331318c05
---
 arch/arm/mach-lpc32xx/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index d792e2e..a6e2aed 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -66,6 +66,7 @@
 
 #include <linux/suspend.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <asm/cacheflush.h>
 
-- 
1.6.6.1
