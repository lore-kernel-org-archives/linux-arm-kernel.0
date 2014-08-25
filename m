From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:40 +0900
Subject: [PATCH 1/2] ARM: shmobile: armadillo800eva-reference: Sort includes
In-Reply-To: <cover.1408927475.git.horms+renesas@verge.net.au>
References: <cover.1408927475.git.horms+renesas@verge.net.au>
Message-ID: <0eb07c96ee61be109f48c32e3970efec76829deb.1408927475.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorted includes seems to be the done thing these days.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 84bc6cb..c392632 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -21,9 +21,9 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
-- 
2.0.1
