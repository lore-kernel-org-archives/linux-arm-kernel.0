From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 20 Aug 2012 13:49:37 +0800
Subject: [PATCH 1/3] ARM: pxa: append the definition of CKENC
Message-ID: <1345441779-22632-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
index 207ecb4..f4d48d2 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
@@ -131,6 +131,7 @@
 #define AICSR		__REG(0x41340008)	/* Application Subsystem Interrupt Control/Status Register */
 #define CKENA		__REG(0x4134000C)	/* A Clock Enable Register */
 #define CKENB		__REG(0x41340010)	/* B Clock Enable Register */
+#define CKENC		__REG(0x41340024)	/* C Clock Enable Register */
 #define AC97_DIV	__REG(0x41340014)	/* AC97 clock divisor value register */
 
 #define ACCR_XPDIS		(1 << 31)	/* Core PLL Output Disable */
-- 
1.7.9.5
