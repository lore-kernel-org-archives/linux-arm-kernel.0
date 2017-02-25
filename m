From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 22:50:29 +0200
Subject: [PATCH] ASoC: pxa: Remove spaces before tabs
Message-ID: <1488055829-12898-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c | 6 +++---
 sound/soc/pxa/pxa2xx-pcm.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 27aa0e4..3fb60ba 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -46,10 +46,10 @@
 #define SACR0_STRF	(1 << 5)	/* FIFO Select for EFWR Special Function */
 #define SACR0_EFWR	(1 << 4)	/* Enable EFWR Function  */
 #define SACR0_RST	(1 << 3)	/* FIFO, i2s Register Reset */
-#define SACR0_BCKD	(1 << 2) 	/* Bit Clock Direction */
+#define SACR0_BCKD	(1 << 2)	/* Bit Clock Direction */
 #define SACR0_ENB	(1 << 0)	/* Enable I2S Link */
 #define SACR1_ENLBF	(1 << 5)	/* Enable Loopback */
-#define SACR1_DRPL	(1 << 4) 	/* Disable Replaying Function */
+#define SACR1_DRPL	(1 << 4)	/* Disable Replaying Function */
 #define SACR1_DREC	(1 << 3)	/* Disable Recording Function */
 #define SACR1_AMSL	(1 << 0)	/* Specify Alternate Mode */

@@ -60,7 +60,7 @@
 #define SASR0_TFS	(1 << 3)	/* Tx FIFO Service Request */
 #define SASR0_BSY	(1 << 2)	/* I2S Busy */
 #define SASR0_RNE	(1 << 1)	/* Rx FIFO Not Empty */
-#define SASR0_TNF	(1 << 0) 	/* Tx FIFO Not Empty */
+#define SASR0_TNF	(1 << 0)	/* Tx FIFO Not Empty */

 #define SAICR_ROR	(1 << 6)	/* Clear Rx FIFO Overrun Interrupt */
 #define SAICR_TUR	(1 << 5)	/* Clear Tx FIFO Underrun Interrupt */
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 410d48b..b51d7a0 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -85,7 +85,7 @@ static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 }

 static struct snd_soc_platform_driver pxa2xx_soc_platform = {
-	.ops 	= &pxa2xx_pcm_ops,
+	.ops		= &pxa2xx_pcm_ops,
 	.pcm_new	= pxa2xx_soc_pcm_new,
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
--
1.9.1
