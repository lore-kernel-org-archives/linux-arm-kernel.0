From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Wed, 2 Jan 2013 10:11:40 +0000
Subject: [PATCH 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
In-Reply-To: <20121214180905.GX4989@atomide.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
 <20121214180905.GX4989@atomide.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD484A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 23:39:05, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [121120 23:01]:
> > This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
> > ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
> > leds and D_CAN drivers in omap2plus_defconfig.
> > 
> > These are the peripherals present in AM33XX family of devices.
> > 
> > AnilKumar Ch (7):
> >   ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
> >   ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
> >   ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
> >   ARM: OMAP2+: omap2plus_defconfig: Enable matrix keypad driver
> >   ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
> >   ARM: OMAP2+: omap2plus_defconfig: Enable leds-gpio driver
> >   ARM: OMAP2+: omap2plus_defconfig: Enable DCAN controller
> > 
> >  arch/arm/configs/omap2plus_defconfig |   17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> 
> Let's make all these into modules except for the tps65910.
> 

Happy New Year Tony,

I will send the updated series with the changes. Selecting leds-gpio
driver as module is not supported, so leds-gpio driver is enabled
by default and rest of the drivers as modules.

Thanks
AnilKumar
