From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:55 +0200
Subject: [PATCH 0112/1529] Fix typo
Message-ID: <20160521115055.5174-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-pxa/regs-u2d.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/regs-u2d.h b/arch/arm/mach-pxa/regs-u2d.h
index c15c0c5..d8febd6 100644
--- a/arch/arm/mach-pxa/regs-u2d.h
+++ b/arch/arm/mach-pxa/regs-u2d.h
@@ -159,7 +159,7 @@
 #define U2DMACSR_EORIRQEN	(1 << 28)	/* End of Receive Interrupt Enable (R/W) */
 #define U2DMACSR_EORJMPEN	(1 << 27)	/* Jump to next descriptor on EOR */
 #define U2DMACSR_EORSTOPEN	(1 << 26)	/* STOP on an EOR */
-#define U2DMACSR_RASIRQEN	(1 << 23)	/* Request After Cnannel Stopped Interrupt Enable */
+#define U2DMACSR_RASIRQEN	(1 << 23)	/* Request After Channel Stopped Interrupt Enable */
 #define U2DMACSR_MASKRUN	(1 << 22)	/* Mask Run */
 #define U2DMACSR_SCEMC		(3 << 18)	/* System Bus Split Completion Error Message Class */
 #define U2DMACSR_SCEMI		(0x1f << 13)	/* System Bus Split Completion Error Message Index */
-- 
2.8.2.534.g1f66975
