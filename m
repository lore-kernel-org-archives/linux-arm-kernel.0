From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Wed, 21 May 2014 09:43:20 +0530
Subject: [PATCH 1/1] arm64: tlbflush.h: Clean up comment
In-Reply-To: <1400645600-35973-1-git-send-email-ritesh.harjani@gmail.com>
References: <1400645600-35973-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1400645600-35973-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Clean up the undefined function name(flush_kern_tlb_page)
from the comment in tlbflush.h

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm64/include/asm/tlbflush.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 8b48203..85e4f98 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -63,12 +63,6 @@ extern struct cpu_tlb_fns cpu_tlb;
  *		- vaddr - virtual address (may not be aligned)
  *		- vma	- vma_struct describing address range
  *
- *	flush_kern_tlb_page(kaddr)
- *
- *		Invalidate the TLB entry for the specified page.  The address
- *		will be in the kernels virtual memory space.  Current uses
- *		only require the D-TLB to be invalidated.
- *		- kaddr - Kernel virtual memory address
  */
 static inline void flush_tlb_all(void)
 {
-- 
1.8.1.3
