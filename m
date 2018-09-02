From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  2 Sep 2018 19:16:21 +0200
Subject: [PATCH] ARM: bcm2835_defconfig: Enable bcm2835-audio
Message-ID: <1535908581-3970-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the bcm2835-audio driver, which depends on bcm2835-vchiq.
After that we gain more test coverage (e.g. Kernel CI).

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index e9bc889..bb6a35f 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -128,7 +128,7 @@ CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_STAGING=y
-CONFIG_BCM2835_VCHIQ=m
+CONFIG_SND_BCM2835=m
 CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.7.4
