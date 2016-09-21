From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 21 Sep 2016 08:23:46 +0000
Subject: [PATCH V7 5/6] ARM: bcm2835: add thermal driver to default_config
In-Reply-To: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1474446227-1147-6-git-send-email-kernel@martin.sperl.org>
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
index 79de828..4b89f4e 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -73,6 +73,8 @@ CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
 CONFIG_DRM=y
-- 
2.1.4
