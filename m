From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:48 +0200
Subject: [PATCH 0102/1529] Fix typo
Message-ID: <20160521114948.4664-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap1/ams-delta-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index d1f1209..acd6bf0 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -136,7 +136,7 @@ void __init ams_delta_init_fiq(void)
 		fiq_buffer[i] = 0;
 
 	/*
-	 * FIQ mode r9 always points to the fiq_buffer, becauses the FIQ isr
+	 * FIQ mode r9 always points to the fiq_buffer, because the FIQ isr
 	 * will run in an unpredictable context. The fiq_buffer is the FIQ isr's
 	 * only means of communication with the IRQ level and other kernel
 	 * context code.
-- 
2.8.2.534.g1f66975
