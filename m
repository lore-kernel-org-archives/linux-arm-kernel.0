From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:30:44 +0900
Subject: [PATCH 6/6] staging: board: armadillo800eva: Use "arm,pl390"
In-Reply-To: <cover.1450401902.git.horms+renesas@verge.net.au>
References: <cover.1450401902.git.horms+renesas@verge.net.au>
Message-ID: <1474136ce6a457a10a797b3de04adbb035e90901.1450401902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/staging/board/armadillo800eva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
index 9c41652ee908..912c96b0536d 100644
--- a/drivers/staging/board/armadillo800eva.c
+++ b/drivers/staging/board/armadillo800eva.c
@@ -97,7 +97,7 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
 
 static void __init armadillo800eva_init(void)
 {
-	board_staging_gic_setup_xlate("arm,cortex-a9-gic", 32);
+	board_staging_gic_setup_xlate("arm,pl390", 32);
 	board_staging_register_devices(armadillo800eva_devices,
 				       ARRAY_SIZE(armadillo800eva_devices));
 }
-- 
2.1.4
