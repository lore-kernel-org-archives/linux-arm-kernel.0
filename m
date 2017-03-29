From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Wed, 29 Mar 2017 06:15:37 +0100
Subject: [PATCH 3/3] fixed extra space coding issue
In-Reply-To: <d34e8125d5819066756e245e5759b39932afafa0.1490760735.git.sfaragnaus@gmail.com>
References: <cover.1490760735.git.sfaragnaus@gmail.com>
 <a7afd06fb8a7e36568e639020c07662692da2589.1490760735.git.sfaragnaus@gmail.com>
 <d34e8125d5819066756e245e5759b39932afafa0.1490760735.git.sfaragnaus@gmail.com>
Message-ID: <d0b16544fd6f2a6a736e285cc6f168f50438edb9.1490760735.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed an extra spaces at the end of the line

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index f1ce5cf..451942a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -539,7 +539,7 @@ int snd_bcm2835_new_spdif_pcm(struct bcm2835_chip *chip)
 	/* NOTE: this may fail */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 					      snd_dma_continuous_data(GFP_KERNEL),
-					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max, 
+					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max,
 					      snd_bcm2835_playback_spdif_hw.buffer_bytes_max);
 out:
 	mutex_unlock(&chip->audio_mutex);
-- 
2.4.10
