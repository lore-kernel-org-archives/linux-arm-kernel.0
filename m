From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 May 2011 13:44:11 +0200
Subject: [PATCH 2/3] sound/atmel-pcm: trivial: typo in atmel_pcm_dma_params
	strucutre comment
In-Reply-To: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
References: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4690ba475772c4edd963009ad570394df5745a96.1306409927.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel-pcm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 2597329..5e0a95e 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -60,7 +60,7 @@ struct atmel_ssc_mask {
  * This structure, shared between the PCM driver and the interface,
  * contains all information required by the PCM driver to perform the
  * PDC DMA operation.  All fields except dma_intr_handler() are initialized
- * by the interface.  The dms_intr_handler() pointer is set by the PCM
+ * by the interface.  The dma_intr_handler() pointer is set by the PCM
  * driver and called by the interface SSC interrupt handler if it is
  * non-NULL.
  */
-- 
1.7.3
