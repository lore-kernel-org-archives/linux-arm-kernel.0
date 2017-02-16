From: tsu.yubo@gmail.com (Bo YU)
Date: Thu, 16 Feb 2017 09:59:07 -0500
Subject: [PATCH] Staging: bcm2835-audio: fixed a code style issue:
Message-ID: <20170216145904.GA5867@yubo-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing a blank line after declarations

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
  drivers/staging/bcm2835-audio/bcm2835-pcm.c |    1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
index 014bf7ab69f4..16127e062661 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-pcm.c
@@ -450,6 +450,7 @@ static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
  	unsigned int cmd, void *arg)
  {
  	int ret = snd_pcm_lib_ioctl(substream, cmd, arg);
+
  	audio_info(" .. substream=%p, cmd=%d, arg=%p (%x) ret=%d\n", substream,
  		cmd, arg, arg ? *(unsigned *) arg : 0, ret);
  	return ret;
--
1.7.10.4
