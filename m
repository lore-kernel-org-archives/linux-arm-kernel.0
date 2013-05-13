From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:37 +0400
Subject: [PATCH 15/15] ARM: clps711x: Update defconfig
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-18-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 1cd94c3..9e8c831 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -31,21 +31,18 @@ CONFIG_EP7211_DONGLE=y
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_AUTCPU12=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
 CONFIG_CS89x0=y
 CONFIG_CS89x0_PLATFORM=y
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -63,7 +60,11 @@ CONFIG_CS89x0_PLATFORM=y
 # CONFIG_VT is not set
 CONFIG_SERIAL_CLPS711X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
+CONFIG_SPI_CLPS711X=y
+CONFIG_GPIO_CLPS711X=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
@@ -87,4 +88,3 @@ CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-# CONFIG_CRC32 is not set
-- 
1.8.1.5
