From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:37 +0900
Subject: [PATCH 1/5] ARM: shmobile: lager defconfig: Enable RSPI and MTD_M25P80
In-Reply-To: <cover.1392962286.git.horms+renesas@verge.net.au>
References: <cover.1392962286.git.horms+renesas@verge.net.au>
Message-ID: <917163578a3dcfa3bfc05cc3bfc2653e2994971b.1392962286.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This enables support for the Spansion s25fl512s SPI FLASH on QSPI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/lager_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index b17f487..5870244 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -51,6 +51,8 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_M25P80=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
@@ -86,6 +88,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_RCAR=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
 CONFIG_GPIO_SH_PFC=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_RCAR=y
-- 
1.8.5.2
