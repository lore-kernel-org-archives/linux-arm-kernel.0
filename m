From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:26 +0900
Subject: [PATCH 04/14] ARM: shmobile: Remove sh7372 use of <mach/hardware.h>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <3a8e257f2464870cff1c4257838af2698b9e23fd.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 13e6fdb..3118783 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -35,7 +35,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <mach/dma-register.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
 #include <mach/common.h>
-- 
1.8.3.2
