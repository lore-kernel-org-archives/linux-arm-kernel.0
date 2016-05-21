From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:53:07 +0200
Subject: [PATCH 0129/1529] Fix typo
Message-ID: <20160521115307.6132-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/xen/mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index c5f9a9e..483da5e 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -150,7 +150,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 *	- The Linux page refers to foreign memory
 	 *	- The device doesn't support coherent DMA request
 	 *
-	 * The Linux page may be spanned acrros multiple Xen page, although
+	 * The Linux page may be spanned across multiple Xen page, although
 	 * it's not possible to have a mix of local and foreign Xen page.
 	 * Furthermore, range_straddles_page_boundary is already checking
 	 * if buffer is physically contiguous in the host RAM.
-- 
2.8.2.534.g1f66975
