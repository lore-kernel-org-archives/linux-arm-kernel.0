From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  5 Mar 2013 19:50:21 -0700
Subject: [PATCH 2/2] ARM: bcm2835: defconfig update
In-Reply-To: <1362538221-19296-1-git-send-email-swarren@wwwdotorg.org>
References: <1362538221-19296-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1362538221-19296-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the new SPI controller driver.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index af472e4..297921d 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -63,6 +63,8 @@ CONFIG_TTY_PRINTK=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_BCM2835=y
+CONFIG_SPI=y
+CONFIG_SPI_BCM2835=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
@@ -108,9 +110,5 @@ CONFIG_TEST_KSTRTOX=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-# CONFIG_XZ_DEC_X86 is not set
-# CONFIG_XZ_DEC_POWERPC is not set
-# CONFIG_XZ_DEC_IA64 is not set
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
-# CONFIG_XZ_DEC_SPARC is not set
-- 
1.7.10.4
