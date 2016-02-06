From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  6 Feb 2016 22:01:08 +0000
Subject: [PATCH 1/2] ARM: bcm2835_defconfig: Enable RPi firmware driver
In-Reply-To: <1454796069-26830-1-git-send-email-stefan.wahren@i2se.com>
References: <1454796069-26830-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1454796069-26830-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the Raspberry Pi driver for GPU specific features.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 7c20a0b..9377f1b 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -108,6 +108,7 @@ CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
+CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.7.9.5
