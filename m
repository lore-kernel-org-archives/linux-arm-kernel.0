From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:11:43 +0100
Subject: [PATCH 4/5] ARM: bcm2835_defconfig: Enable Raspberry Pi OTP driver
In-Reply-To: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542805904-6446-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Raspberry Pi OTP driver, which could be helpful for
custom Compute Module designs.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index bb6a35f..4c1405e 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -136,6 +136,8 @@ CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_RASPBERRYPI_OTP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.7.4
