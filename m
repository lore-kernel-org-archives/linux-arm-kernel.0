From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Tue, 17 Nov 2009 12:49:22 +0100
Subject: [PATCH] ep93xx: add missing parentheses in IOMEM macro
Message-ID: <200911171249.22049.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index 594b77f..ddb6e32 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -14,7 +14,7 @@
  * A typesafe __io() variation for variable initialisers
  */
 #ifdef __ASSEMBLER__
-#define IOMEM(p)		p
+#define IOMEM(p)		(p)
 #else
 #define IOMEM(p)		((void __iomem __force *)(p))
 #endif
-- 
1.6.4.4
