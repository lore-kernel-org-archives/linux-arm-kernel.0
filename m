From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 17 Jan 2013 10:09:23 +0100
Subject: [PATCH v2] ARM: spear3xx: Fix pl080-related build failure
Message-ID: <1358413763-21507-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/amba/pl080.h to pull in the various PL080_* macros.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/mach-spear3xx/spear3xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index f9d754f..7c218d9 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
 
 #include <linux/amba/pl022.h>
+#include <linux/amba/pl080.h>
 #include <linux/amba/pl08x.h>
 #include <linux/io.h>
 #include <plat/pl080.h>
-- 
1.8.1.1
