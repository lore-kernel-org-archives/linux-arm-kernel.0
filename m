From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Sun, 9 Apr 2017 00:25:44 +0100
Subject: [PATCH v3 2/2] staging: vc04_services: bcm2835-audio: bcm2835-pcm.c
 Fixed codepatch coding style issue, line over 80
In-Reply-To: <cover.1491693395.git.sfaragnaus@gmail.com>
References: <cover.1491693395.git.sfaragnaus@gmail.com>
Message-ID: <cf95bd8f3b992b83eb274acf03a9c0206d1036d9.1491693395.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed checkpatch warning about line over 80 chars

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
Changes in v3:
- rebased on staging-testing

 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index a2cc09a..ae1a16e 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -521,7 +521,8 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	/* NOTE: this may fail */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 					      snd_dma_continuous_data(GFP_KERNEL),
-					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max,
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
 
-- 
2.4.10
