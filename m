From: liu.xiang6@zte.com.cn (Liu Xiang)
Date: Sun, 25 Nov 2018 17:27:54 +0800
Subject: [PATCH] arm64: mm: Add spaces around + operator
Message-ID: <1543138074-3556-1-git-send-email-liu.xiang6@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add spaces around '+' to follow kernel coding style.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d1d6601..1dbd7be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -853,7 +853,7 @@ void __set_fixmap(enum fixed_addresses idx,
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 	} else {
 		pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 	}
 }
 
-- 
1.9.1
