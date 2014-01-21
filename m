From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 21 Jan 2014 10:17:47 +0900
Subject: [PATCH] arm64: mm: fix the function name in comment of
 __flush_dcache_area
Message-ID: <000001cf1646$98202900$c8607b00$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the function name of comment of __flush_dcache_area,
because __flush_dcache_area is the correct name. Also,
the missing variable 'size' is added to the comment.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm64/mm/cache.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 48a3860..1ea9f26 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -146,7 +146,7 @@ ENDPROC(flush_icache_range)
 ENDPROC(__flush_cache_user_range)
 
 /*
- *	__flush_kern_dcache_page(kaddr)
+ *	__flush_dcache_area(kaddr, size)
  *
  *	Ensure that the data held in the page kaddr is written back to the
  *	page in question.
-- 
1.7.10.4
