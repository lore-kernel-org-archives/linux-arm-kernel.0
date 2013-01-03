From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Thu, 3 Jan 2013 07:54:38 +0000
Subject: [PATCH v3 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
In-Reply-To: <CAOesGMj0yO5JxkDAeN1negip5dvwX9Y3syoU4JPsKnVJ0GucdQ@mail.gmail.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
 <CAOesGMj0yO5JxkDAeN1negip5dvwX9Y3syoU4JPsKnVJ0GucdQ@mail.gmail.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD6FD3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 01:49:57, Olof Johansson wrote:
> Hi,
> 
> On Wed, Jan 2, 2013 at 2:27 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
> > ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
> > leds and D_CAN drivers in omap2plus_defconfig.
> >
> > These are the peripherals present in AM33XX family of devices.
> >
> > Changes from v2:
> >         - Incorporated Tony's comments on v2
> >           * Enabled as modules instead of kernel built-in drivers.
> >         - Dropped 1st patch because it was accepted.
> >
> > Changes from v1:
> >         - Incorporated martinez javier's comments on v1
> >           * Enabled few more triggers in omap2plus_defconfig
> >         - Included Igor's patch, which modifies the omap2plus
> >           defconfig for AM33XX devices.
> >
> > AnilKumar Ch (7):
> >   ARM: OMAP2+: omap2plus_defconfig: Add tps65910 support
> >   ARM: OMAP2+: omap2plus_defconfig: Add lis3lv02d support
> >   ARM: OMAP2+: omap2plus_defconfig: Add tsl2550 support
> >   ARM: OMAP2+: omap2plus_defconfig: Add matrix-keypad support
> >   ARM: OMAP2+: omap2plus_defconfig: Add tmp275 sensor support
> >   ARM: OMAP2+: omap2plus_defconfig: Add leds-gpio support
> >   ARM: OMAP2+: omap2plus_defconfig: Add D_CAN support
> 
> Doing this as 7 separate patches seems excessive to me. Just do it as
> one single patch instead.
> 

Hi Olof,

I will send v4 by merging all the patches into single patch.

Thanks
AnilKumar
