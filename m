From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:55:08 +0900
Subject: [PATCH 1/3] ARM: shmobile: sh73a0: Spelling/grammar s/entity
 map/identity mapping/
In-Reply-To: <cover.1416530979.git.horms+renesas@verge.net.au>
References: <cover.1416530979.git.horms+renesas@verge.net.au>
Message-ID: <178a2b07ee4cdf6868464bb8d40bf3364b51e498.1416530979.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 0754b12..1622fb2 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -45,7 +45,7 @@
 #include "sh73a0.h"
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
+	/* create a 1:1 identity mapping for 0xe6xxxxxx
 	 * used by CPGA, INTC and PFC.
 	 */
 	{
-- 
2.1.1
