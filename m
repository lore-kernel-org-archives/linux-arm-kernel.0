From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  3 Mar 2015 11:58:06 +0100
Subject: [PATCH trivial/resend 1/9] ARM: KVM: Spelling s/auxilliary/auxiliary/
In-Reply-To: <1425380294-26137-1-git-send-email-geert+renesas@glider.be>
References: <1425380294-26137-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1425380294-26137-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-arm-kernel at lists.infradead.org
---
Resending trivial patches submitted in 2014.

 arch/arm/include/asm/kvm_asm.h   | 2 +-
 arch/arm64/include/asm/kvm_asm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 25410b2d8bc1046c..194c91b610ffecfd 100644
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
index 4f7310fa77f01acd..c4c11d20ca172cf7 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -27,7 +27,7 @@
 #define	MPIDR_EL1	1	/* MultiProcessor Affinity Register */
 #define	CSSELR_EL1	2	/* Cache Size Selection Register */
 #define	SCTLR_EL1	3	/* System Control Register */
-#define	ACTLR_EL1	4	/* Auxilliary Control Register */
+#define	ACTLR_EL1	4	/* Auxiliary Control Register */
 #define	CPACR_EL1	5	/* Coprocessor Access Control */
 #define	TTBR0_EL1	6	/* Translation Table Base Register 0 */
 #define	TTBR1_EL1	7	/* Translation Table Base Register 1 */
-- 
1.9.1
