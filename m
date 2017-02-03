From: vicmos89@gmail.com (Victor Vaschenko)
Date: Sat,  4 Feb 2017 02:18:41 +0300
Subject: [PATCH] One coding style correction.
Message-ID: <1486163921-29331-1-git-send-email-vicmos89@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Victor Vaschenko <vicmos89@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-ctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
index 164daa4..bfb7e9f 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
@@ -164,8 +164,7 @@ static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
 		.get = snd_bcm2835_ctl_get,
 		.put = snd_bcm2835_ctl_put,
 		.count = 1,
-		.tlv =
-		{.p = snd_bcm2835_db_scale}
+		.tlv = {.p = snd_bcm2835_db_scale}
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
--
1.9.1
