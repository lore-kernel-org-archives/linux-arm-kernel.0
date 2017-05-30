From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:39 +0200
Subject: [PATCH 58/58] ARM: multi_v5_defconfig: Remove ATMEL_TCLIB Kconfig
 symbol
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-59-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_tclib driver is now removed, remove it from the configs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/multi_v5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 69a4bd13eea5..de835577bb3b 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -95,7 +95,6 @@ CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=m
 CONFIG_EEPROM_AT24=y
 # CONFIG_SCSI_PROC_FS is not set
-- 
2.11.0
