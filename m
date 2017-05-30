From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:37 +0200
Subject: [PATCH 56/58] ARM: configs: at91: remove ATMEL_TCLIB
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-57-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_tclib driver is now removed, remove its config symbol.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 -
 arch/arm/configs/sama5_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 9d068f07b84b..3ec7afe7a6c9 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -64,7 +64,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 161d6221ce6e..edda4b5cbcfd 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -74,7 +74,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
-- 
2.11.0
