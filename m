From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:05:37 -0700
Subject: [PATCH 02/29] ARM: OMAP: Remove smp.h
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210536.28074.58176.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/smp.h |    5 -----
 arch/arm/mach-omap2/include/mach/smp.h |    5 -----
 2 files changed, 10 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/smp.h

diff --git a/arch/arm/mach-omap1/include/mach/smp.h b/arch/arm/mach-omap1/include/mach/smp.h
deleted file mode 100644
index 80a371c..0000000
--- a/arch/arm/mach-omap1/include/mach/smp.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/smp.h
- */
-
-#include <plat/smp.h>
diff --git a/arch/arm/mach-omap2/include/mach/smp.h b/arch/arm/mach-omap2/include/mach/smp.h
deleted file mode 100644
index 323675f..0000000
--- a/arch/arm/mach-omap2/include/mach/smp.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/smp.h
- */
-
-#include <plat/smp.h>
