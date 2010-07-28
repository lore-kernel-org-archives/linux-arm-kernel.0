From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 19:12:06 +0900
Subject: [PATCH 4/6] S5PV310: Define OneNAND interrupt number
Message-ID: <20100728101206.GA21345@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Define OneNAND interrupt for s5pv310

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 56885ca..f7fb2b8 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -66,6 +66,8 @@
 
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
 
+#define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
+
 /* Set the default NR_IRQS */
 #define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
 
-- 
1.5.3.3
