From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Aug 2014 11:52:47 +0900
Subject: [PATCH repost 3/5] ARM: shmobile: armadillo800eva-reference: Sort
 includes
In-Reply-To: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
References: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1407725569-31413-4-git-send-email-horms+renesas@verge.net.au>
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
