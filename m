From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:29 +0900
Subject: [PATCH 07/14] ARM: shmobile: Remove Marzen use of <mach/hardware.h>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <85469abe4930fb001c79ac5f0ca17b65c7b2580d.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on Marzen.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a7d1010..1f57865 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -37,7 +37,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
-#include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
-- 
1.8.3.2
