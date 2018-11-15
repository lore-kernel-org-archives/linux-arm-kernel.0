From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Nov 2018 11:03:30 +0100
Subject: [PATCH] ARM: Correct meaning of SCU in HAVE_ARM_SCU help txt
Message-ID: <20181115100330.17943-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the ARM Cortex-A5 and Cortex-A9 Technical Reference
Manuals, SCU stands for "Snoop Control Unit".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df658ccd..1b7c73facaed9849 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1347,7 +1347,7 @@ config SCHED_SMT
 config HAVE_ARM_SCU
 	bool
 	help
-	  This option enables support for the ARM system coherency unit
+	  This option enables support for the ARM snoop control unit
 
 config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
-- 
2.17.1
