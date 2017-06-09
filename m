From: srishtishar@gmail.com (srishti sharma)
Date: Sat, 10 Jun 2017 02:37:22 +0530
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c: Fixed
 alignment to match open parenthesis.
Message-ID: <1497042442-3620-1-git-send-email-srishtishar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed alignment so that it matched open parenthesis.

Signed-off-by: srishti sharma <srishtishar@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index f484bb0..2148ed0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -105,7 +105,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
	int changed = 0;
--
2.7.4
