From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 10:09:05 -0800
Subject: [PATCH 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
In-Reply-To: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Message-ID: <20121214180905.GX4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [121120 23:01]:
> This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
> ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
> leds and D_CAN drivers in omap2plus_defconfig.
> 
> These are the peripherals present in AM33XX family of devices.
> 
> AnilKumar Ch (7):
>   ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
>   ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
>   ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
>   ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad driver
>   ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
>   ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
>   ARM: OMAP2+: omap2plus_defconfig: Enable DCAN controller
> 
>  arch/arm/configs/omap2plus_defconfig |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Let's make all these into modules except for the tps65910.

Regards,

Tony
