From: james.morse@arm.com (James Morse)
Date: Tue,  8 Dec 2015 11:48:20 +0000
Subject: [PATCH] fixup! arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
References: <1448559168-8363-11-git-send-email-james.morse@arm.com>
Message-ID: <1449575300-9612-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

additional includes should go after the #ifdef guards

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/suspend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e75ad7aa268c..6682178783eb 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -1,8 +1,8 @@
-#include <linux/suspend.h>
-
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
+#include <linux/suspend.h>
+
 #define NR_CTX_REGS 10
 #define NR_CALLEE_SAVED_REGS 12
 
-- 
2.6.2
