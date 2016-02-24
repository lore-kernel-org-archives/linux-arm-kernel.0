From: adam.buchbinder@gmail.com (Adam Buchbinder)
Date: Wed, 24 Feb 2016 09:52:41 -0800
Subject: [PATCH v2] arm64: Fix misspellings in comments.
In-Reply-To: <20160224102351.GB28310@arm.com>
References: <20160224102351.GB28310@arm.com>
Message-ID: <1456336361-30697-1-git-send-email-adam.buchbinder@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 +-
 arch/arm64/include/asm/ftrace.h          | 2 +-
 arch/arm64/include/asm/kvm_arm.h         | 2 +-
 arch/arm64/include/asm/kvm_host.h        | 4 ++--
 arch/arm64/kernel/fpsimd.c               | 2 +-
 arch/arm64/kernel/kgdb.c                 | 4 ++--
 arch/arm64/kernel/signal32.c             | 2 +-
 arch/arm64/lib/memcmp.S                  | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index e8bb460..6e28e41 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -313,7 +313,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra124-uart", "nvidia,tegra20-uart" and to enable
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index bc23f4d..23b0630 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -345,7 +345,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra124-uart", "nvidia,tegra20-uart" and to enable
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 3c60f37..caa955f 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -48,7 +48,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
  * See kernel/trace/trace_syscalls.c
  *
  * x86 code says:
- * If the user realy wants these, then they should use the
+ * If the user really wants these, then they should use the
  * raw syscall tracepoints with filtering.
  */
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index d201d4b..0215b57 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -61,7 +61,7 @@
 
 /*
  * The bits we set in HCR:
- * RW:		64bit by default, can be overriden for 32bit VMs
+ * RW:		64bit by default, can be overridden for 32bit VMs
  * TAC:		Trap ACTLR
  * TSC:		Trap SMC
  * TVM:		Trap VM ops (until M+C set in SCTLR_EL1)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 689d4c9..56284eb 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -99,8 +99,8 @@ enum vcpu_sysreg {
 	TTBR1_EL1,	/* Translation Table Base Register 1 */
 	TCR_EL1,	/* Translation Control Register */
 	ESR_EL1,	/* Exception Syndrome Register */
-	AFSR0_EL1,	/* Auxilary Fault Status Register 0 */
-	AFSR1_EL1,	/* Auxilary Fault Status Register 1 */
+	AFSR0_EL1,	/* Auxiliary Fault Status Register 0 */
+	AFSR1_EL1,	/* Auxiliary Fault Status Register 1 */
 	FAR_EL1,	/* Fault Address Register */
 	MAIR_EL1,	/* Memory Attribute Indirection Register */
 	VBAR_EL1,	/* Vector Base Address Register */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index acc1afd..975b274 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -45,7 +45,7 @@
  *     been used to perform kernel mode NEON in the meantime.
  *
  * For (a), we add a 'cpu' field to struct fpsimd_state, which gets updated to
- * the id of the current CPU everytime the state is loaded onto a CPU. For (b),
+ * the id of the current CPU every time the state is loaded onto a CPU. For (b),
  * we add the per-cpu variable 'fpsimd_last_state' (below), which contains the
  * address of the userland FPSIMD state of the task that was loaded onto the CPU
  * the most recently, or NULL if kernel mode NEON has been performed after that.
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index bcac81e..b67531a 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -292,8 +292,8 @@ static struct notifier_block kgdb_notifier = {
 };
 
 /*
- * kgdb_arch_init - Perform any architecture specific initalization.
- * This function will handle the initalization of any architecture
+ * kgdb_arch_init - Perform any architecture specific initialization.
+ * This function will handle the initialization of any architecture
  * specific callbacks.
  */
 int kgdb_arch_init(void)
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 71ef6dc..71c1cf4 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -166,7 +166,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 #ifdef BUS_MCEERR_AO
 		/*
 		 * Other callers might not initialize the si_lsb field,
-		 * so check explicitely for the right codes here.
+		 * so check explicitly for the right codes here.
 		 */
 		if (from->si_signo == SIGBUS &&
 		    (from->si_code == BUS_MCEERR_AR || from->si_code == BUS_MCEERR_AO))
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index ffbdec0..f9903d0 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -211,7 +211,7 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )
 .Lunequal_proc:
 	cbz	diff, .Lremain8
 
-/*There is differnence occured in the latest comparison.*/
+/*There is difference occurred in the latest comparison.*/
 .Lnot_limit:
 /*
 * For little endian,reverse the low significant equal bits into MSB,then
-- 
2.7.0.rc3.207.g0ac5344
