From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:28 +0400
Subject: [PATCH 15/17] ARM clps711x: Removed unused definitions from
 mach/irqs.h
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-16-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/irqs.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/irqs.h b/arch/arm/mach-clps711x/include/mach/irqs.h
index 30b7e97..3e0c341 100644
--- a/arch/arm/mach-clps711x/include/mach/irqs.h
+++ b/arch/arm/mach-clps711x/include/mach/irqs.h
@@ -35,7 +35,6 @@
 #define IRQ_SSEOTI			15
 
 #define INT1_IRQS			(0x0000fff0)
-#define INT1_ACK_IRQS			(0x00004f10)
 
 /*
  * Interrupts from INTSR2
@@ -47,7 +46,6 @@
 #define IRQ_URXINT2			(16+13)	/* bit 13 */
 
 #define INT2_IRQS			(0x30070000)
-#define INT2_ACK_IRQS			(0x00010000)
 
 #define NR_IRQS                         30
 
-- 
1.7.3.4
