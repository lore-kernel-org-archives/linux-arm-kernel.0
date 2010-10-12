From: sbkim73@samsung.com (Sangbeom Kim)
Date: Tue, 12 Oct 2010 16:16:03 +0900
Subject: [PATCH] ARM: S5PV310: Update MAX_COMBINER_NR
Message-ID: <1286867763-21515-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch updates MAX_COMBINER_NR from 39 to 40 because
S5PV310 need 39th combiner for including EINT16_31.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index b2acc62..f301af7 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -89,6 +89,6 @@
 
 #define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
-#define MAX_COMBINER_NR		39
+#define MAX_COMBINER_NR		40
 
 #endif /* __ASM_ARCH_IRQS_H */
-- 
1.6.2.5
