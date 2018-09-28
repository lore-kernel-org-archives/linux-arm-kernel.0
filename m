From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:22:43 +0200
Subject: [PATCH 1/7] ARM: shmobile: r8a7779: Remove unused includes
In-Reply-To: <cover.1538123953.git.horms+renesas@verge.net.au>
References: <cover.1538123953.git.horms+renesas@verge.net.au>
Message-ID: <ad73cc2b913273df971cf318d0fe40785376dbcd.1538123953.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Presumable unused since commit c99cd90d98a98aa1 ("ARM: shmobile:
r8a7779: Remove legacy SoC code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index d589326099e0..b13ec9088ce5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -7,9 +7,7 @@
  * Copyright (C) 2013  Cogent Embedded, Inc.
  */
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/arm-gic.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-- 
2.11.0
