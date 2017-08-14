From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:19:41 +0100
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Message-ID: <1502709581-26546-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for r8a7743/5 SoC.Renesas RZ/G1[ME] (R8A7743/5) SDHI
is identical to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch is compiled and tested against mmc/next.

 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 718cb8a..f709f7f 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -95,6 +95,8 @@
 	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
-- 
1.9.1
