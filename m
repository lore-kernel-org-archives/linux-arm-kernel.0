From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 07 Oct 2011 15:28:06 +0100
Subject: [PATCH 2/5 v4] ARM Realview PCIX IRQ include file changes
In-Reply-To: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007142753.19554.59765.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Interrupt definitions for the PCI
support on the Realview boards.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/mach-realview/include/mach/irqs-pb11mp.h |   11 +++++++++++
 arch/arm/mach-realview/include/mach/irqs-pba8.h   |    7 ++++++-
 arch/arm/mach-realview/include/mach/irqs-pbx.h    |    7 ++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/irqs-pb11mp.h b/arch/arm/mach-realview/include/mach/irqs-pb11mp.h
index 34e255a..cd3e3e6 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pb11mp.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pb11mp.h
@@ -95,6 +95,17 @@
 #define IRQ_PB11MP_TSPEN	(IRQ_PB11MP_GIC_START + 30)	/* Touchscreen pen */
 #define IRQ_PB11MP_TSKPAD	(IRQ_PB11MP_GIC_START + 31)	/* Touchscreen keypad */
 
+/* These PCI/PCIe IRQ definitions are here as placeholders
+ * The PCI code actually calculates the irq used at runtime */
+#define IRQ_PB11MP_PCI0		(IRQ_PB11MP_GIC_START + 50)
+#define IRQ_PB11MP_PCI1		(IRQ_PB11MP_GIC_START + 51)
+#define IRQ_PB11MP_PCI2		(IRQ_PB11MP_GIC_START + 52)
+#define IRQ_PB11MP_PCI3		(IRQ_PB11MP_GIC_START + 53)
+#define IRQ_PB11MP_PCIE0	(IRQ_PB11MP_GIC_START + 54)
+#define IRQ_PB11MP_PCIE1	(IRQ_PB11MP_GIC_START + 55)
+#define IRQ_PB11MP_PCIE2	(IRQ_PB11MP_GIC_START + 56)
+#define IRQ_PB11MP_PCIE3	(IRQ_PB11MP_GIC_START + 57)
+
 #define IRQ_PB11MP_SMC		-1
 #define IRQ_PB11MP_SCTL		-1
 
diff --git a/arch/arm/mach-realview/include/mach/irqs-pba8.h b/arch/arm/mach-realview/include/mach/irqs-pba8.h
index 4a88a4e..da6d583 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pba8.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pba8.h
@@ -61,11 +61,16 @@
 
 #define IRQ_PBA8_PMU		(IRQ_PBA8_GIC_START + 47)	/* Cortex-A8 PMU */
 
-/* ... */
+/* These PCI/PCIe IRQ definitions are here as placeholders
+ * The PCI code actually calculates the irq used at runtime */
 #define IRQ_PBA8_PCI0		(IRQ_PBA8_GIC_START + 50)
 #define IRQ_PBA8_PCI1		(IRQ_PBA8_GIC_START + 51)
 #define IRQ_PBA8_PCI2		(IRQ_PBA8_GIC_START + 52)
 #define IRQ_PBA8_PCI3		(IRQ_PBA8_GIC_START + 53)
+#define IRQ_PBA8_PCIE0		(IRQ_PBA8_GIC_START + 54)
+#define IRQ_PBA8_PCIE1		(IRQ_PBA8_GIC_START + 55)
+#define IRQ_PBA8_PCIE2		(IRQ_PBA8_GIC_START + 56)
+#define IRQ_PBA8_PCIE3		(IRQ_PBA8_GIC_START + 57)
 
 #define IRQ_PBA8_SMC		-1
 #define IRQ_PBA8_SCTL		-1
diff --git a/arch/arm/mach-realview/include/mach/irqs-pbx.h b/arch/arm/mach-realview/include/mach/irqs-pbx.h
index 206a300..f661702 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pbx.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pbx.h
@@ -76,11 +76,16 @@
 #define IRQ_PBX_PMU_CPU2        (IRQ_PBX_GIC_START + 46)
 #define IRQ_PBX_PMU_CPU3        (IRQ_PBX_GIC_START + 47)
 
-/* ... */
+/* These PCI/PCIe IRQ definitions are here as placeholders
+ * The PCI code actually calculates the irq used at runtime */
 #define IRQ_PBX_PCI0		(IRQ_PBX_GIC_START + 50)
 #define IRQ_PBX_PCI1		(IRQ_PBX_GIC_START + 51)
 #define IRQ_PBX_PCI2		(IRQ_PBX_GIC_START + 52)
 #define IRQ_PBX_PCI3		(IRQ_PBX_GIC_START + 53)
+#define IRQ_PBX_PCIE0		(IRQ_PBX_GIC_START + 54)
+#define IRQ_PBX_PCIE1		(IRQ_PBX_GIC_START + 55)
+#define IRQ_PBX_PCIE2		(IRQ_PBX_GIC_START + 56)
+#define IRQ_PBX_PCIE3		(IRQ_PBX_GIC_START + 57)
 
 #define IRQ_PBX_SMC		-1
 #define IRQ_PBX_SCTL		-1
