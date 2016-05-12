From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 12 May 2016 12:38:52 +0000
Subject: [PATCH 4/4] ARM: bcm2835_defconfig: add bcm2835-sdram controller
In-Reply-To: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463056732-5607-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the bcm2835-sdram controller driver to the default config.
(as the driver is enabled by default vi KConfig, we only need
to enable CONFIG_MEMORY)

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1ef69fc..29a44bd 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -107,6 +107,7 @@ CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_MEMORY=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
--
2.1.4
