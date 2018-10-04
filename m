From: kyrylo.tkachov@arm.com (Kyrylo Tkachov)
Date: Thu,  4 Oct 2018 17:06:46 +0100
Subject: [PATCH] Fix typo in a comment in arch/arm64/mm/kasan_init.c
Message-ID: <20181004160646.3348-1-kyrylo.tkachov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"bellow" -> "below"

The recommendation from kegel.com/kerspell is to only fix the howlers.
"Bellow" is a synonym of "howl" so this should be appropriate.

Signed-off-by: Kyrylo Tkachov <kyrylo.tkachov@arm.com>
---
 arch/arm64/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 12145874c02b..fccb1a6f8c6f 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -192,7 +192,7 @@ void __init kasan_init(void)
 
 	/*
 	 * We are going to perform proper setup of shadow memory.
-	 * At first we should unmap early shadow (clear_pgds() call bellow).
+	 * At first we should unmap early shadow (clear_pgds() call below).
 	 * However, instrumented code couldn't execute without shadow memory.
 	 * tmp_pg_dir used to keep early shadow mapped until full shadow
 	 * setup will be finished.
-- 
2.19.0
