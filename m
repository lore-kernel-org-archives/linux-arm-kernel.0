From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 10:40:56 +0100
Subject: [PATCH] ARM: sunxi: change the AllWinner A1X to sunxi
In-Reply-To: <20140115091006.GF3377@lukather>
References: <20140109153404.GA21055@kvmhost> <20140115091006.GF3377@lukather>
Message-ID: <3612364.BZBltgonI0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 10:10:06 Maxime Ripard wrote:
> On Thu, Jan 09, 2014 at 04:34:04PM +0100, Gerardo Di Iorio wrote:
> > Change the AllWinner A1X SOCs to Allwinner Sunxi SOCs
> > 
> > Signed-off-by: Gerardo Di Iorio <arete74@gmail.com>
> > ---
> >  arch/arm/mach-sunxi/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index 547004c..adb2574 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -1,5 +1,5 @@
> >  config ARCH_SUNXI
> > -       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> > +       bool "Allwinner Sunxi SOCs" if ARCH_MULTI_V7
> 
> I wonder if the sunxi (apart the weird letter case) is actually
> needed. Maybe we can just put "Allwinner SoCs" (it would be great if
> you could fix the SoCs case too).

If you want to have exact naming, try to find something that excludes the
old Sun3i (F20) and earlier chips (unless someone is already planning
to work on them). Maybe also mention the "Boxchip" name, although that
seems to be falling out of use these days.

	Arnd
