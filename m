From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Thu, 30 Mar 2017 20:41:49 +0800
Subject: [PATCH] arm64: remove redundant header file in current.h
Message-ID: <1490877709-221439-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commint 9d84fb27fa1 ("arm64: restore get_current() optimisation") has 
removed read_sysreg() and asm/sysreg.h is redundant.

This patch removes asm/sysreg.h header file.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/include/asm/current.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/current.h b/arch/arm64/include/asm/current.h
index 86c4041..f6580d4 100644
--- a/arch/arm64/include/asm/current.h
+++ b/arch/arm64/include/asm/current.h
@@ -3,8 +3,6 @@
 
 #include <linux/compiler.h>
 
-#include <asm/sysreg.h>
-
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-- 
1.9.1
