From: vishalthanki@gmail.com (Vishal Thanki)
Date: Mon, 21 Mar 2016 15:51:01 +0100
Subject: [PATCH] ARM: scu: Add missing header file
Message-ID: <1458571861-20290-1-git-send-email-vishalthanki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header file is required to resovle EINVAL symbol,
otherwise can possibly cause a compilation failure.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
---
 arch/arm/include/asm/smp_scu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c..9d07670 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/cputype.h>
+#include <linux/err.h>
 
 static inline bool scu_a9_has_base(void)
 {
-- 
2.4.3
