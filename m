From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Jul 2011 13:41:52 -0400
Subject: [PATCH] ARM: S5PC100: Fix for compilation error
Message-ID: <1309801312-27377-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: padmavathi venna <padma.v@samsung.com>

S5PC100 Compilation fails without this patch

Signed-off-by: padmavathi venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pc100/dev-spi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
index 2b58c9a..e5d6c4d 100644
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -15,6 +15,7 @@
 #include <mach/dma.h>
 #include <mach/map.h>
 #include <mach/spi-clocks.h>
+#include <mach/irqs.h>
 
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
-- 
1.7.0.4
