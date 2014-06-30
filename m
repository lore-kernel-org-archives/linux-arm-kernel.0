From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:27 +0900
Subject: [PATCH 17/17] ASoC: Samsung: remove s5pc100 related codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-18-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes s5pc100 related codes in
<linux/platform_data/asoc-s3c.h>.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@linaro.org>
---
 include/linux/platform_data/asoc-s3c.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 709c6f7..a6591c6 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -15,15 +15,6 @@
 #define S3C64XX_AC97_GPE  1
 extern void s3c64xx_ac97_setup_gpio(int);
 
-/*
- * The machine init code calls s5p*_spdif_setup_gpio with
- * one of these defines in order to select appropriate bank
- * of GPIO for S/PDIF pins
- */
-#define S5PC100_SPDIF_GPD  0
-#define S5PC100_SPDIF_GPG3 1
-extern void s5pc100_spdif_setup_gpio(int);
-
 struct samsung_i2s {
 /* If the Primary DAI has 5.1 Channels */
 #define QUIRK_PRI_6CHAN		(1 << 0)
-- 
1.7.10.4
