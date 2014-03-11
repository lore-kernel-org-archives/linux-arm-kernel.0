From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Mar 2014 11:23:39 +0100
Subject: [PATCH trivial 05/16] arm64: mm: Remove superfluous "the" in comment
In-Reply-To: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
References: <1394533430-4746-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1394533430-4746-5-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa3917c8b623..b38d5de4a29d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -412,7 +412,7 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
 /*
  * Ensure that there are not more swap files than can be encoded in the kernel
- * the PTEs.
+ * PTEs.
  */
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
 
-- 
1.7.9.5
