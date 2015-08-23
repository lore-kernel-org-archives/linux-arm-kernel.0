From: kuleshovmail@gmail.com (Alexander Kuleshov)
Date: Sun, 23 Aug 2015 19:24:44 +0600
Subject: [PATCH] arm64: Fix source code file path in comments
Message-ID: <1440336284-3907-1-git-send-email-kuleshovmail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architecture specific code for i386 and x86_64 was unified and merged to
the arch/x86. This patch fix old path of x86 architecture in a comment
from the arch/arm64/include/asm/fixmap.h.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/arm64/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index c0739187..8b9884c 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -8,7 +8,7 @@
  * Copyright (C) 1998 Ingo Molnar
  * Copyright (C) 2013 Mark Salter <msalter@redhat.com>
  *
- * Adapted from arch/x86_64 version.
+ * Adapted from arch/x86 version.
  *
  */
 
-- 
2.5.0
