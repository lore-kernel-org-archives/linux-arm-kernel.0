From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:28 +0000
Subject: [PATCH-V2 4/6] ARM: bcm2835_defconfig: add bcm2835-sdram controller
In-Reply-To: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
References: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463586030-2778-5-git-send-email-kernel@martin.sperl.org>
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
index f254d6b..634e07e 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -109,6 +109,7 @@ CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_MEMORY=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
-- 
2.1.4
