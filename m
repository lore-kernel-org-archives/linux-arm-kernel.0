From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:02:56 +0530
Subject: [PATCH v2 0/8] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
Message-ID: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
leds and D_CAN drivers in omap2plus_defconfig.

These are the peripherals present in AM33XX family of devices.

Changes from v1:
	- Incorporated martinez javier's comments on v1
	  * Enabled few more triggers in omap2plus_defconfig
	- Included Igor's patch, which modifies the omap2plus
	  defconfig for AM33XX devices.

AnilKumar Ch (7):
  ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
  ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
  ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad driver
  ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
  ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
  ARM: OMAP2+: omap2plus_defconfig: Enable DCAN controller

Igor Mazanov (1):
  ARM: OMAP2+: omap2plus_defconfig: Enable tps65217 PMIC

 arch/arm/configs/omap2plus_defconfig |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
1.7.9.5
