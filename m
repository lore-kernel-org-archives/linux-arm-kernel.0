From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Jul 2012 23:27:40 +0200
Subject: [PATCH] arm,unicore32: Remove obsolete "select MISC_DEVICES"
Message-ID: <1342733260-10737-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Obsoleted since commit 7c5763b8453a94871d356f20df30f350f8631e8b ("drivers:
misc: Remove MISC_DEVICES config option")

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-davinci/Kconfig |    6 ------
 arch/unicore32/Kconfig        |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 32d837d..0e5f0a1 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -61,7 +61,6 @@ config MACH_DAVINCI_EVM
 	bool "TI DM644x EVM"
 	default ARCH_DAVINCI_DM644x
 	depends on ARCH_DAVINCI_DM644x
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
@@ -71,7 +70,6 @@ config MACH_DAVINCI_EVM
 config MACH_SFFSDR
 	bool "Lyrtech SFFSDR"
 	depends on ARCH_DAVINCI_DM644x
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
@@ -105,7 +103,6 @@ config MACH_DAVINCI_DM6467_EVM
 	default ARCH_DAVINCI_DM646x
 	depends on ARCH_DAVINCI_DM646x
 	select MACH_DAVINCI_DM6467TEVM
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
@@ -119,7 +116,6 @@ config MACH_DAVINCI_DM365_EVM
 	bool "TI DM365 EVM"
 	default ARCH_DAVINCI_DM365
 	depends on ARCH_DAVINCI_DM365
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
@@ -131,7 +127,6 @@ config MACH_DAVINCI_DA830_EVM
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
 	select GPIO_PCF857X
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
@@ -218,7 +213,6 @@ config MACH_TNETV107X
 config MACH_MITYOMAPL138
 	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
 	depends on ARCH_DAVINCI_DA850
-	select MISC_DEVICES
 	select EEPROM_AT24
 	select I2C
 	help
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 03c9ff8..b0a4743 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -238,7 +238,6 @@ config I2C_BATTERY_BQ27200
 config I2C_EEPROM_AT24
 	tristate "I2C EEPROMs AT24 support"
 	select I2C_PUV3
-	select MISC_DEVICES
 	select EEPROM_AT24
 
 config LCD_BACKLIGHT
-- 
1.7.0.4
