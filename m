From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:34:12 +0900
Subject: [PATCH 1/8] ARM: shmobile: r8a7779: Rename DU device in clock lookups
 list
In-Reply-To: <cover.1380530437.git.horms+renesas@verge.net.au>
References: <cover.1380530437.git.horms+renesas@verge.net.au>
Message-ID: <acf47ee741c4a5eb8a17438e8858f1cffa1e073a.1380530437.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU device will be called rcar-du-r8a7779. Rename the clock lookup
entry accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index bd6ad92..1f7080f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -200,7 +200,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
-	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
+	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
 void __init r8a7779_clock_init(void)
-- 
1.8.4
