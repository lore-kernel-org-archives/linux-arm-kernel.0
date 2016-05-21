From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:53:00 +0200
Subject: [PATCH 0128/1529] Fix typo
Message-ID: <20160521115300.6081-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/probes/kprobes/opt-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index bcdecc2..b165881 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -320,7 +320,7 @@ void __kprobes arch_optimize_kprobes(struct list_head *oplist)
 
 		/*
 		 * Make it a conditional branch if replaced insn
-		 * is consitional
+		 * is conditional
 		 */
 		insn = (__mem_to_opcode_arm(
 			  op->optinsn.copied_insn[0]) & 0xf0000000) |
-- 
2.8.2.534.g1f66975
