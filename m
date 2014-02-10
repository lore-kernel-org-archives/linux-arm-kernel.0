From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 11:47:31 +0100
Subject: [PATCH 5/7] ARM: shmobile: lager defconfig: Enable RSPI and MTD_M25P80
In-Reply-To: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1392029254-15400-6-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This enables support for the Spansion s25fl512s SPI FLASH on QSPI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/configs/lager_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 235772f7c81d..b17fc23ae676 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -51,6 +51,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_WIRELESS is not set
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
1.7.9.5
