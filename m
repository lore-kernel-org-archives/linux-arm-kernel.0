From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 15:04:54 +0000
Subject: [RFC PATCH v2 06/12] arm64: fpsimd: include <linux/init.h> in fpsimd.h
In-Reply-To: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519657500-15094-7-git-send-email-will.deacon@arm.com>
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
