From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 10:42:59 -0800
Subject: [PATCH v4] ARM: OMAP2+: AM33XX: omap2plus_defconfig: Add
 support for few drivers
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAF03E7@DBDE01.ent.ti.com>
References: <1357202279-6094-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAF03E7@DBDE01.ent.ti.com>
Message-ID: <20130201184259.GN22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar, Chimata <anilkumar@ti.com> [130118 03:23]:
> On Thu, Jan 03, 2013 at 14:07:59, AnilKumar, Chimata wrote:
> > Adds tps65910 PMIC, lis3lv02d accelerometer, tsl2550 ambient light sensor,
> > tmp275 temperature sensor, matrix keypad, gbio based leds and D_CAN drivers
> > support. These peripherals are present on AM33XX family of devices (EVM,
> > BeagleBone and EVMSK). One has to manually enable these support to use the
> > drivers, so this patch enables all the drivers in omap2plus_defconfig
> 
> Hi Tony,
> 
> Could you please pull this patch, if there are no further comments?

Thanks applying into omap-for-v3.9/board.

Regards,

Tony
