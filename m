From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Fri, 26 Nov 2010 13:09:14 +0100
Subject: [PATCH] ARM: ux500: Increased nr of interrupts for ab8500
Message-ID: <1290773354-9177-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will increase the number of virtual interrupts
for ab8500 v2 since eight more interrupts was added in the latest
chip version.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
---
 .../mach-ux500/include/mach/irqs-board-mop500.h    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
index 7ee8aaa..08f0638 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -8,7 +8,7 @@
 #ifndef __MACH_IRQS_BOARD_MOP500_H
 #define __MACH_IRQS_BOARD_MOP500_H
 
-#define AB8500_NR_IRQS			104
+#define AB8500_NR_IRQS			112
 
 #define MOP500_AB8500_IRQ_BASE		IRQ_BOARD_START
 #define MOP500_AB8500_IRQ_END		(MOP500_AB8500_IRQ_BASE \
-- 
1.7.2.2
