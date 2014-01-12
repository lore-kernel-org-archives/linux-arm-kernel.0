From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 14:10:28 +0100
Subject: [PATCH TRIVIAL] ARM: KVM: Spelling s/auxilliary/auxiliary/
Message-ID: <1389532228-6690-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/include/asm/kvm_asm.h   |    2 +-
 arch/arm64/include/asm/kvm_asm.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 661da11f76f4..cc185243c7f7 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -23,7 +23,7 @@
 #define c0_MPIDR	1	/* MultiProcessor ID Register */
 #define c0_CSSELR	2	/* Cache Size Selection Register */
 #define c1_SCTLR	3	/* System Control Register */
-#define c1_ACTLR	4	/* Auxilliary Control Register */
+#define c1_ACTLR	4	/* Auxiliary Control Register */
 #define c1_CPACR	5	/* Coprocessor Access Control */
 #define c2_TTBR0	6	/* Translation Table Base Register 0 */
 #define c2_TTBR0_high	7	/* TTBR0 top 32 bits */
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b25763bc0ec4..6643c1f5a38c 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -25,7 +25,7 @@
 #define	MPIDR_EL1	1	/* MultiProcessor Affinity Register */
 #define	CSSELR_EL1	2	/* Cache Size Selection Register */
 #define	SCTLR_EL1	3	/* System Control Register */
-#define	ACTLR_EL1	4	/* Auxilliary Control Register */
+#define	ACTLR_EL1	4	/* Auxiliary Control Register */
 #define	CPACR_EL1	5	/* Coprocessor Access Control */
 #define	TTBR0_EL1	6	/* Translation Table Base Register 0 */
 #define	TTBR1_EL1	7	/* Translation Table Base Register 1 */
-- 
1.7.9.5
