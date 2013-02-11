From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Feb 2013 12:01:46 -0200
Subject: [PATCH 1/3] ARM: mxs: mm: Fix sparse warning
Message-ID: <1360591308-7482-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include <mach/common.h> header to fix the following sparse warnings:

arch/arm/mach-mxs/mm.c:43:13: warning: symbol 'mx23_map_io' was not declared. Should it be static?
arch/arm/mach-mxs/mm.c:48:13: warning: symbol 'mx28_map_io' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
index a4294aa..e63b7d8 100644
--- a/arch/arm/mach-mxs/mm.c
+++ b/arch/arm/mach-mxs/mm.c
@@ -18,6 +18,7 @@
 
 #include <mach/mx23.h>
 #include <mach/mx28.h>
+#include <mach/common.h>
 
 /*
  * Define the MX23 memory map.
-- 
1.7.9.5
