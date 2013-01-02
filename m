From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 2 Jan 2013 15:57:24 +0530
Subject: [PATCH v3 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
Message-ID: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
leds and D_CAN drivers in omap2plus_defconfig.

These are the peripherals present in AM33XX family of devices.

Changes from v2:
	- Incorporated Tony's comments on v2
	  * Enabled as modules instead of kernel built-in drivers.
	- Dropped 1st patch because it was accepted.

Changes from v1:
	- Incorporated martinez javier's comments on v1
	  * Enabled few more triggers in omap2plus_defconfig
	- Included Igor's patch, which modifies the omap2plus
	  defconfig for AM33XX devices.

AnilKumar Ch (7):
  ARM: OMAP2+: omap2plus_defconfig: Add tps65910 support
  ARM: OMAP2+: omap2plus_defconfig: Add lis3lv02d support
  ARM: OMAP2+: omap2plus_defconfig: Add tsl2550 support
  ARM: OMAP2+: omap2plus_defconfig: Add matrix-keypad support
  ARM: OMAP2+: omap2plus_defconfig: Add tmp275 sensor support
  ARM: OMAP2+: omap2plus_defconfig: Add leds-gpio support
  ARM: OMAP2+: omap2plus_defconfig: Add D_CAN support

 arch/arm/configs/omap2plus_defconfig |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
1.7.9.5
