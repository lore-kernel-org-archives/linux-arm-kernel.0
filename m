From: baozich@gmail.com (Chen Baozi)
Date: Fri,  3 Jan 2014 22:17:23 +0800
Subject: [PATCH] arm/xen: remove redundant semicolon in definition of
 ioremap_cached
Message-ID: <1388758643-3897-1-git-send-email-baozich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Wei Liu <liuw@liuw.name>
Signed-off-by: Chen Baozi <baozich@gmail.com>
---
 arch/arm/include/asm/xen/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index b3368df..8a6155f 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -120,7 +120,7 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 #ifdef CONFIG_ARM64
 #define xen_remap(cookie, size) ioremap_cache((cookie), (size))
 #else
-#define xen_remap(cookie, size) ioremap_cached((cookie), (size));
+#define xen_remap(cookie, size) ioremap_cached((cookie), (size))
 #endif
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
-- 
1.8.4.3
