From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 27 Jan 2014 16:19:32 +0900
Subject: [PATCH] arm64: mm: fix the function name in comment of
 cpu_do_switch_mm
Message-ID: <000801cf1b30$1ffe8db0$5ffba910$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the function name of comment of cpu_do_switch_mm,
because cpu_do_switch_mm is the correct name.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm64/mm/proc.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index bed1f1d..1333e6f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -150,7 +150,7 @@ ENDPROC(cpu_do_resume)
 #endif
 
 /*
- *	cpu_switch_mm(pgd_phys, tsk)
+ *	cpu_do_switch_mm(pgd_phys, tsk)
  *
  *	Set the translation table base pointer to be pgd_phys.
  *
-- 
1.7.10.4
