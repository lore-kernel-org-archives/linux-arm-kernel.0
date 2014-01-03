From: wei.liu2@citrix.com (Wei Liu)
Date: Fri, 3 Jan 2014 14:03:35 +0000
Subject: [PATCH] asm/xen/page.h: remove redundant semicolon
Message-ID: <1388757815-11394-1-git-send-email-wei.liu2@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Liu <liuw@liuw.name>

Signed-off-by: Wei Liu <liuw@liuw.name>
---
 arch/arm/include/asm/xen/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 75579a9..ac6789a 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -117,6 +117,6 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 	return __set_phys_to_machine(pfn, mfn);
 }
 
-#define xen_remap(cookie, size) ioremap_cached((cookie), (size));
+#define xen_remap(cookie, size) ioremap_cached((cookie), (size))
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
-- 
1.7.10.4
