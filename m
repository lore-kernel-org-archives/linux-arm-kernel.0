From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  6 May 2011 13:08:43 +0200
Subject: [PATCH] avr32: add some more at91 to cpu.h definition
Message-ID: <1304680123-20218-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Somme common drivers will need those at91 cpu_is_xxx() definitions.
Those definitions are already in Linus' tree so if we want to use them
in common drivers, we will need them in AVR32 cpu.h file.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/avr32/mach-at32ap/include/mach/cpu.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/mach-at32ap/include/mach/cpu.h b/arch/avr32/mach-at32ap/include/mach/cpu.h
index 9c96a13..a927d9e 100644
--- a/arch/avr32/mach-at32ap/include/mach/cpu.h
+++ b/arch/avr32/mach-at32ap/include/mach/cpu.h
@@ -31,8 +31,21 @@
 #define cpu_is_at91sam9263()	(0)
 #define cpu_is_at91sam9rl()	(0)
 #define cpu_is_at91cap9()	(0)
+#define cpu_is_at91cap9_revB()	(0)
+#define cpu_is_at91cap9_revC()	(0)
 #define cpu_is_at91sam9g10()	(0)
+#define cpu_is_at91sam9g20()	(0)
 #define cpu_is_at91sam9g45()	(0)
 #define cpu_is_at91sam9g45es()	(0)
+#define cpu_is_at91sam9m10()	(0)
+#define cpu_is_at91sam9g46()	(0)
+#define cpu_is_at91sam9m11()	(0)
+#define cpu_is_at91sam9x5()	(0)
+#define cpu_is_at91sam9g15()	(0)
+#define cpu_is_at91sam9g35()	(0)
+#define cpu_is_at91sam9x35()	(0)
+#define cpu_is_at91sam9g25()	(0)
+#define cpu_is_at91sam9x25()	(0)
+
 
 #endif /* __ASM_ARCH_CPU_H */
-- 
1.7.3
