From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 11:22:06 +0000
Subject: [PATCH v6 4/4] ARM: bcm2835: enable auxiliary spi driver in defconfig
In-Reply-To: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441970527-2403-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

add the auxiliar spi driver to the default config

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/configs/bcm2835_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 31cb073..a205c8b 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -75,6 +75,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_BCM2835=y
 CONFIG_SPI=y
 CONFIG_SPI_BCM2835=y
+CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
--
1.7.10.4
