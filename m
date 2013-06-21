From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:57:21 +0200
Subject: [PATCH 4/4] staging: drm/imx: ipu-dmfc: use defines for ipu channel
 numbers
In-Reply-To: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
References: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371805041-9299-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
index 1dc9817..2e97c33 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
@@ -61,7 +61,7 @@ struct dmfc_channel_data {
 
 static const struct dmfc_channel_data dmfcdata[] = {
 	{
-		.ipu_channel	= 23,
+		.ipu_channel	= IPUV3_CHANNEL_MEM_BG_SYNC,
 		.channel_reg	= DMFC_DP_CHAN,
 		.shift		= DMFC_DP_CHAN_5B_23,
 		.eot_shift	= 20,
@@ -73,13 +73,13 @@ static const struct dmfc_channel_data dmfcdata[] = {
 		.eot_shift	= 22,
 		.max_fifo_lines	= 1,
 	}, {
-		.ipu_channel	= 27,
+		.ipu_channel	= IPUV3_CHANNEL_MEM_FG_SYNC,
 		.channel_reg	= DMFC_DP_CHAN,
 		.shift		= DMFC_DP_CHAN_5F_27,
 		.eot_shift	= 21,
 		.max_fifo_lines	= 2,
 	}, {
-		.ipu_channel	= 28,
+		.ipu_channel	= IPUV3_CHANNEL_MEM_DC_SYNC,
 		.channel_reg	= DMFC_WR_CHAN,
 		.shift		= DMFC_WR_CHAN_1_28,
 		.eot_shift	= 16,
-- 
1.8.3.1
