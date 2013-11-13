From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 13 Nov 2013 14:39:47 -0300
Subject: [PATCH] bus: mvebu-mbus: Remove deprecated comment
Message-ID: <1384364387-3391-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a comment about the lack of a devicetree binding: this driver's
binding is already implemented and in use.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index c646a76..725c461 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -588,12 +588,6 @@ static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
 
-/*
- * The driver doesn't yet have a DT binding because the details of
- * this DT binding still need to be sorted out. However, as a
- * preparation, we already use of_device_id to match a SoC description
- * string against the SoC specific details of this driver.
- */
 static const struct of_device_id of_mvebu_mbus_ids[] = {
 	{ .compatible = "marvell,armada370-mbus",
 	  .data = &armada_370_xp_mbus_data, },
-- 
1.8.1.5
