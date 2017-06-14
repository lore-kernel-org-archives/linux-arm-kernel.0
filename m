From: srishtishar@gmail.com (srishti sharma)
Date: Thu, 15 Jun 2017 01:04:55 +0530
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c: Fixed
 alignment to match open parenthesis
Message-ID: <1497468895-3061-1-git-send-email-srishtishar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed alignment so that it matched open parenthesis.

Signed-off-by: srishti sharma <srishtishar@gmail.com>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835-ctl.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index f484bb0..ce8ab36 100644
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
@@ -185,7 +185,7 @@ static struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 };

 static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+					  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -193,7 +193,7 @@ static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
@@ -210,7 +210,7 @@ static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int val = 0;
@@ -230,7 +230,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+				       struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -238,7 +238,7 @@ static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+				      struct snd_ctl_elem_value *ucontrol)
 {
 	/*
 	 * bcm2835 supports only consumer mode and sets all other format flags
@@ -249,7 +249,7 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_stream_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+					 struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -257,7 +257,7 @@ static int snd_bcm2835_spdif_stream_info(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
@@ -274,7 +274,7 @@ static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
 }

 static int snd_bcm2835_spdif_stream_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int val = 0;
--
2.7.4
