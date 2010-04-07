From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  7 Apr 2010 11:40:37 +0300
Subject: [PATCH] [ARM] pxa/regs-u2d: add missing new line.
Message-ID: <1270629637-3257-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/include/mach/regs-u2d.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h b/arch/arm/mach-pxa/include/mach/regs-u2d.h
index 44b0b20..c15c0c5 100644
--- a/arch/arm/mach-pxa/include/mach/regs-u2d.h
+++ b/arch/arm/mach-pxa/include/mach/regs-u2d.h
@@ -166,7 +166,8 @@
 #define U2DMACSR_BUSERRTYPE	(7 << 10)	/* PX Bus Error Type */
 #define U2DMACSR_EORINTR	(1 << 9)	/* End Of Receive */
 #define U2DMACSR_REQPEND	(1 << 8)	/* Request Pending */
-#define U2DMACSR_RASINTR	(1 << 4)	/* Request After Channel Stopped (read / write 1 clear) */#define U2DMACSR_STOPINTR	(1 << 3)	/* Stop Interrupt (read only) */
+#define U2DMACSR_RASINTR	(1 << 4)	/* Request After Channel Stopped (read / write 1 clear) */
+#define U2DMACSR_STOPINTR	(1 << 3)	/* Stop Interrupt (read only) */
 #define U2DMACSR_ENDINTR	(1 << 2)	/* End Interrupt (read / write 1 clear) */
 #define U2DMACSR_STARTINTR	(1 << 1)	/* Start Interrupt (read / write 1 clear) */
 #define U2DMACSR_BUSERRINTR	(1 << 0)	/* Bus Error Interrupt (read / write 1 clear) */
-- 
1.6.4.4
