From: baozich@gmail.com (Chen Baozi)
Date: Fri,  3 Jan 2014 23:10:18 +0800
Subject: [PATCH V2] arm/xen: remove redundant semicolon in definition of
 ioremap_cache
Message-ID: <1388761818-4646-1-git-send-email-baozich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 <- v1: Edit based on Rob's patch

Reported-by: Wei Liu <liuw@liuw.name>
Signed-off-by: Chen Baozi <baozich@gmail.com>
---
 arch/arm/include/asm/xen/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 3759cac..fba7995 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -117,6 +117,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
-#define xen_remap(cookie, size) ioremap_cache((cookie), (size));
+#define xen_remap(cookie, size) ioremap_cache((cookie), (size))
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
-- 
1.8.4.3
