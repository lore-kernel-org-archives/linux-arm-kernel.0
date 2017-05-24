From: srishtishar@gmail.com (srishti sharma)
Date: Wed, 24 May 2017 20:03:14 +0530
Subject: [PATCH] Staging: bcm2835-audio: bcm2835-ctl.c: Fixed a comment coding
 style issue.
Message-ID: <1495636394-2431-1-git-send-email-srishtishar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixed a trailing */ issue

Signed-off-by: srishti sharma <srishtishar@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835-ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
index a4ffa1b..38fabab 100644
--- a/drivers/staging/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
@@ -247,8 +247,8 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	/* bcm2835 supports only consumer mode and sets all other format flags
-	 * automatically. So the only thing left is signalling non-audio
-	 * content */
+	 * automatically. So the only thing left is signalling non-audio content
+	 */
 	ucontrol->value.iec958.status[0] = IEC958_AES0_NONAUDIO;
 	return 0;
 }
2.7.4
