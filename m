From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:53 +0900
Subject: [PATCH 05/14] ARM: shmobile: Use r8a7791_add_standard_devices() on
 Koelsch
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <0749bead08db4e01588437a05a126bf4774dae23.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use r8a7791_add_standard_devices() on Koelsch to let
the C version of the board code add on-chip devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index cc2d5e8..278f12e 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -29,7 +29,7 @@
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
-	r8a7791_add_dt_devices();
+	r8a7791_add_standard_devices();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.8.4
