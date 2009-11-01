From: thomas.ab@samsung.com (Thomas Abraham)
Date: Sun,  1 Nov 2009 14:02:21 +0900
Subject: [PATCH 7/7] S3C64XX: Include IDE device code in compilation.
Message-ID: <1257051741-8319-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the makefile to include ide device code
and data for build if S3C IDE driver is selected.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c64xx/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index b85b435..904ce5b 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
+obj-$(CONFIG_BLK_DEV_IDE_S3C)	+= dev-ide.o
-- 
1.5.3.4
