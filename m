From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Tue, 22 Mar 2011 22:48:29 +0200
Subject: [PATCH] ARM: S5PV210: Fix security engine interrupt names
Message-ID: <1300826909-14634-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is intended to correct security subsystem interrupt names
for Samsung S5PV210 and S5PC110 SoCs.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 arch/arm/mach-s5pv210/include/mach/irqs.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 26710b3..b9f9ec3 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -99,9 +99,9 @@
 #define IRQ_TC			IRQ_PENDN
 #define IRQ_KEYPAD		S5P_IRQ_VIC2(25)
 #define IRQ_CG			S5P_IRQ_VIC2(26)
-#define IRQ_SEC			S5P_IRQ_VIC2(27)
-#define IRQ_SECRX		S5P_IRQ_VIC2(28)
-#define IRQ_SECTX		S5P_IRQ_VIC2(29)
+#define IRQ_SSS_INT		S5P_IRQ_VIC2(27)
+#define IRQ_SSS_HASH		S5P_IRQ_VIC2(28)
+#define IRQ_PCM2		S5P_IRQ_VIC2(29)
 #define IRQ_SDMIRQ		S5P_IRQ_VIC2(30)
 #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
 
-- 
1.7.2.3
