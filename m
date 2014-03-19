From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:17 +0100
Subject: [PATCH 20/62] ARM: msm: add missing include of linux/module.h
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-21-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the restructuring of the module.h and init.h headers,
we now need to include this explicitly here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
---
 arch/arm/mach-msm/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index f8f6adf..ba62f02 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/module.h>
 #include <mach/dma.h>
 #include <mach/msm_iomap.h>
 
-- 
1.8.3.2
