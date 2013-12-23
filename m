From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:07 +0900
Subject: [PATCH 02/26] ARM: shmobile: Enable PFC/GPIO on the Koelsch board
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <1a534ecec7cdf90e2089bb0ab7a77a8ccea3c4dc.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7791 PFC and GPIO on the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index ace1711..d099eaf 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -30,6 +30,7 @@
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
+	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
 }
 
-- 
1.8.4
