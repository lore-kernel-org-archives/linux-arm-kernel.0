From: Sven.Schmitt@mixed-mode.de (Sven Schmitt)
Date: Tue, 24 Jul 2018 09:46:05 +0000
Subject: [PATCH v3 2/3] soc: imx: gpc: clean up
Message-ID: <1532425561377.1081@mixed-mode.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused #defines.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 5126185e68c6..35cc1d2dc4d5 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -24,15 +24,11 @@
 #define GPC_PGC_CTRL_OFFS	0x0
 #define GPC_PGC_PUPSCR_OFFS	0x4
 #define GPC_PGC_PDNSCR_OFFS	0x8
-#define GPC_PGC_SW2ISO_SHIFT	0x8
-#define GPC_PGC_SW_SHIFT	0x0
 
 #define GPC_PGC_PCI_PDN		0x200
 #define GPC_PGC_PCI_SR		0x20c
 
 #define GPC_PGC_GPU_PDN		0x260
-#define GPC_PGC_GPU_PUPSCR	0x264
-#define GPC_PGC_GPU_PDNSCR	0x268
 #define GPC_PGC_GPU_SR		0x26c
 
 #define GPC_PGC_DISP_PDN	0x240
-- 
2.17.1
