From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 14:16:46 +0900
Subject: [PATCH 2/3] ARM: EXYNOS4: Add irq definition for kernel global timer
In-Reply-To: <1298870207-1850-1-git-send-email-kgene.kim@samsung.com>
References: <1298870207-1850-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1298870207-1850-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds IRQ_MCT_G0 to irq map. IRQ_MCT_G0 is an interrupt of MCT
comparator and used for kernel global timer.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/irqs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 2dc5900..e3556d4 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -131,6 +131,7 @@
 #define IRQ_MCT_L0		COMBINER_IRQ(51, 0)
 
 #define IRQ_WDT			COMBINER_IRQ(53, 0)
+#define IRQ_MCT_G0		COMBINER_IRQ(53, 4)
 
 #define MAX_COMBINER_NR		54
 
-- 
1.7.1
