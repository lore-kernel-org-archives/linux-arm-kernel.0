From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:45 +0200
Subject: [PATCH 136/199] arch/arm/mach-h720x/common.h: Checkpatch cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-9-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-h720x/common.h:17: WARNING: space prohibited between function name and open parenthesis '('
arch/arm/mach-h720x/common.h:23: WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-h720x/common.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-h720x/common.h b/arch/arm/mach-h720x/common.h
index d8798db..7dd5fa6 100644
--- a/arch/arm/mach-h720x/common.h
+++ b/arch/arm/mach-h720x/common.h
@@ -14,13 +14,13 @@
  */
 
 extern unsigned long h720x_gettimeoffset(void);
-extern void __init h720x_init_irq (void);
+extern void __init h720x_init_irq(void);
 extern void __init h720x_map_io(void);
 
 #ifdef CONFIG_ARCH_H7202
 extern struct sys_timer h7202_timer;
 extern void __init init_hw_h7202(void);
-extern void __init h7202_init_irq (void);
+extern void __init h7202_init_irq(void);
 extern void __init h7202_init_time(void);
 #endif
 
-- 
1.7.1.251.gf80a2
