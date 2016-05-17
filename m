From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 17 May 2016 14:35:52 +0000
Subject: [PATCH V3 4/5] ARM: bcm2835: add thermal driver to default_config
In-Reply-To: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463495753-967-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver to list of compiled modules
in the default config for bcm2835.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 29a44bd..634e07e 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -71,6 +71,8 @@ CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
 CONFIG_FB=y
-- 
2.1.4
