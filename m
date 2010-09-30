From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 13:48:27 +0900
Subject: [PATCH 2/7] ARM: S5PC110: Fix wrong interrupt I2C2 number
Message-ID: <20100930044827.GA16901@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

It's I2C2 interrupt number instead of CAN0.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/irqs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index cdb8ae4..5ab1833 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -55,8 +55,8 @@
 #define IRQ_SPI1		S5P_IRQ_VIC1(16)
 #define IRQ_SPI2		S5P_IRQ_VIC1(17)
 #define IRQ_IRDA		S5P_IRQ_VIC1(18)
-#define IRQ_CAN0		S5P_IRQ_VIC1(19)
-#define IRQ_CAN1		S5P_IRQ_VIC1(20)
+#define IRQ_IIC2		S5P_IRQ_VIC1(19)
+#define IRQ_I2C_HDMI_PHY	S5P_IRQ_VIC1(20)
 #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
 #define IRQ_HSITX		S5P_IRQ_VIC1(22)
 #define IRQ_UHOST		S5P_IRQ_VIC1(23)
-- 
1.5.3.3
