From: vicmos89@gmail.com (Victor Vaschenko)
Date: Mon,  6 Feb 2017 15:48:01 +0300
Subject: [PATCH] Staging: bcm2835-audio: Fixed that open brace should be on
 previous line error in bcm2835-ctl.c
Message-ID: <1486385281-7387-1-git-send-email-vicmos89@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed ERROR: that open brace { should be on the previous line. 
One coding style correction for better readable code.

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
