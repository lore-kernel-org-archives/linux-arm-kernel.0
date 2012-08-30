From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 30 Aug 2012 09:31:42 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Increase maximum possible memory bank size to
 512MiB
In-Reply-To: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346311903-15920-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have larger memory banks than 256MiB. This patch increses
maximum bank size for Exynos-based boards to 512MiB.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/memory.h b/arch/arm/mach-exynos/include/mach/memory.h
index 374ef2c..d4db508 100644
--- a/arch/arm/mach-exynos/include/mach/memory.h
+++ b/arch/arm/mach-exynos/include/mach/memory.h
@@ -15,8 +15,8 @@
 
 #define PLAT_PHYS_OFFSET		UL(0x40000000)
 
-/* Maximum of 256MiB in one bank */
+/* Maximum of 512MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
-#define SECTION_SIZE_BITS	28
+#define SECTION_SIZE_BITS	29
 
 #endif /* __ASM_ARCH_MEMORY_H */
-- 
1.7.12
