From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:05:34 -0700
Subject: [PATCH 01/29] ARM: OMAP: Remove unused param.h
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210534.28074.90970.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/param.h |    8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/param.h

diff --git a/arch/arm/plat-omap/include/plat/param.h b/arch/arm/plat-omap/include/plat/param.h
deleted file mode 100644
index 1eb4dc3..0000000
--- a/arch/arm/plat-omap/include/plat/param.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/param.h
- *
- */
-
-#ifdef CONFIG_OMAP_32K_TIMER_HZ
-#define HZ	CONFIG_OMAP_32K_TIMER_HZ
-#endif
