From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 10 Oct 2012 12:01:37 +0000
Subject: [PATCH] Add McSPI devices found in AM33xx SoC to dtsi
In-Reply-To: <3608180472966131184@unknownmsgid>
References: <CAAek22HhtFc-1XOFrQC8DKZ9VdKyuShE_G_j4581WL15JTNJXg@mail.gmail.com>
 <518397C60809E147AF5323E0420B992E3E9CA61C@DBDE01.ent.ti.com>
 <3608180472966131184@unknownmsgid>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAA078F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 19:54:28, Phil Pokorny wrote:
> On Oct 9, 2012, at 3:36 AM, "Philip, Avinash" <avinashphilip@ti.com>
> wrote:
> 
> > On Tue, Oct 09, 2012 at 10:40:58, Phil Pokorny wrote:
> >> We're using the BeagleBone for a project and we need the SPI devices
> >> available and configured with all available chip selects.
> >>
> >> Please accept the following patch to add these to the base .dtsi file
> >> so they can then be enabled in the beaglebone specific .dts with
> >> minimal fuss.
> >
> > Patch for adding MCSPI in am33xx.dtsi already been sent by me.
> > https://lkml.org/lkml/2012/9/18/32
> 
> Thank you for responding.
> 
> Was that accepted?  It didn't seem to be in the Linux-omap git tree I
> cloned. I need to check the Torvalds mainline kernel.
> 
> I believe the number of chip selects on spi1 is incorrect. There is
> only one (1) CS shown in the hardware documentation for AM33xx.

Which Hardware document are you referring to? TRM shows 2 chip
selects for McSPI1

> 
> Is OMAP4-McSPI the best match for the hardware?  The mcspi driver
> appears to differ only in the register offset used.  A hard coded zero
> value for omap2 and a named constant for omap4. The hardware manual
> for the AM33xx shows the register map starting at zero.
> 
> Thank you,
> Phil P.
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


Regards, 
Gururaja
