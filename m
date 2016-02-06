From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  6 Feb 2016 22:01:09 +0000
Subject: [PATCH 2/2] ARM: bcm2835_defconfig: Enable RPi power domain driver
In-Reply-To: <1454796069-26830-1-git-send-email-stefan.wahren@i2se.com>
References: <1454796069-26830-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1454796069-26830-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enabling the Raspberry Pi firmware driver which allow us to handle
power domains for USB or graphics.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 9377f1b..1ef69fc 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -106,6 +106,7 @@ CONFIG_STAGING=y
 CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
-- 
1.7.9.5
