From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Feb 2018 15:29:31 +0000
Subject: [RFC PATCH 1/5] arm64: fpsimd: include <linux/init.h> in fpsimd.h
In-Reply-To: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
Message-ID: <1518708575-12284-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fpsimd.h uses the __init annotation, so pull in linux/init.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8857a0f0d0f7..fc3527b985ca 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -22,6 +22,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/cache.h>
+#include <linux/init.h>
 #include <linux/stddef.h>
 
 /*
-- 
2.1.4
