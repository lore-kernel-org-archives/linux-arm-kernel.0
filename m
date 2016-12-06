From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:06 +0000
Subject: [PATCH 6/7] arm: Add livepatch to build if CONFIG_LIVEPATCH
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <1481043967-15602-7-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Necessary livepatch file added to makefile.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8..9e70220 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
+obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
-- 
2.7.4
