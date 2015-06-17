From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:05 +0100
Subject: [PATCH v2 4/7] arm/xen: Drop duplicate define mfn_to_virt
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1434551288-14113-5-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/page.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 0b579b2..1bee8ca 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -12,7 +12,6 @@
 #include <xen/interface/grant_table.h>
 
 #define phys_to_machine_mapping_valid(pfn) (1)
-#define mfn_to_virt(m)			(__va(mfn_to_pfn(m) << PAGE_SHIFT))
 
 #define pte_mfn	    pte_pfn
 #define mfn_pte	    pfn_pte
-- 
2.1.4
