From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 May 2011 16:35:53 +0100
Subject: [PATCH/NEXT] ARM: exynos4: fix typo in platsmp.c
Message-ID: <1306164953-31593-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e2a083dc0da9aa6437e14811198379b18cdfa7f8 (ARM: consolidate
SMP cross call implementation) introduced a typo which leads
to a compilation error. Just fix it.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos4/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 8403dd2..c5e65a0 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -22,7 +22,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/hardare/gic.h>
+#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
-- 
1.7.0.4
