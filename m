From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 13 Apr 2018 19:27:55 +0200
Subject: [PATCH 6/9] ARM: bcm2835_defconfig: Enable VCHIQ driver
In-Reply-To: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1523640478-4448-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to gain more test coverage (e.g. Kernel CI) enable
the VCHIQ driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 9fae57c..e4d188f 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -128,6 +128,7 @@ CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_STAGING=y
+CONFIG_BCM2835_VCHIQ=m
 CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
2.7.4
