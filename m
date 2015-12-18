From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:43 +0900
Subject: [PATCH 5/6] staging: board: kzm9d: Use "arm,pl390"
In-Reply-To: <cover.1450401902.git.horms+renesas@verge.net.au>
References: <cover.1450401902.git.horms+renesas@verge.net.au>
Message-ID: <cebbddb6f9cc1d1cce11490903d07c2da228cec9.1450401902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/staging/board/kzm9d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/kzm9d.c b/drivers/staging/board/kzm9d.c
index 8d1eb09bc66e..05a6d434d307 100644
--- a/drivers/staging/board/kzm9d.c
+++ b/drivers/staging/board/kzm9d.c
@@ -11,7 +11,7 @@ static struct resource usbs1_res[] __initdata = {
 
 static void __init kzm9d_init(void)
 {
-	board_staging_gic_setup_xlate("arm,cortex-a9-gic", 32);
+	board_staging_gic_setup_xlate("arm,pl390", 32);
 
 	if (!board_staging_dt_node_available(usbs1_res,
 					     ARRAY_SIZE(usbs1_res))) {
-- 
2.1.4
