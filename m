From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:27 +0900
Subject: [PATCH 05/14] ARM: shmobile: Remove EMEV2 use of <mach/hardware.h>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <7ffdc70e14756135da5949a6c9bc32e2086f3d02.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on EMEV2.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 19980be..fed753d 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -27,7 +27,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
 #include <mach/irqs.h>
-- 
1.8.3.2
