From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 17 Jan 2014 13:06:41 +0100
Subject: [PATCH] ARM: sunxi: change the AllWinner A1X to sunxi
In-Reply-To: <3612364.BZBltgonI0@wuerfel>
References: <20140109153404.GA21055@kvmhost> <20140115091006.GF3377@lukather>
 <3612364.BZBltgonI0@wuerfel>
Message-ID: <20140117120641.GA3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jan 15, 2014 at 10:40:56AM +0100, Arnd Bergmann wrote:
> On Wednesday 15 January 2014 10:10:06 Maxime Ripard wrote:
> > On Thu, Jan 09, 2014 at 04:34:04PM +0100, Gerardo Di Iorio wrote:
> > > Change the AllWinner A1X SOCs to Allwinner Sunxi SOCs
> > > 
> > > Signed-off-by: Gerardo Di Iorio <arete74@gmail.com>
> > > ---
> > >  arch/arm/mach-sunxi/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > > index 547004c..adb2574 100644
> > > --- a/arch/arm/mach-sunxi/Kconfig
> > > +++ b/arch/arm/mach-sunxi/Kconfig
> > > @@ -1,5 +1,5 @@
> > >  config ARCH_SUNXI
> > > -       bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> > > +       bool "Allwinner Sunxi SOCs" if ARCH_MULTI_V7
> > 
> > I wonder if the sunxi (apart the weird letter case) is actually
> > needed. Maybe we can just put "Allwinner SoCs" (it would be great if
> > you could fix the SoCs case too).
> 
> If you want to have exact naming, try to find something that excludes the
> old Sun3i (F20) and earlier chips (unless someone is already planning
> to work on them). Maybe also mention the "Boxchip" name, although that
> seems to be falling out of use these days.

I'm not sure that's good to exclude chips. We have a number of SoCs we
don't support even on later families (A31s, A23, mostly). I'm not sure
we want to have an ever growing list of SoCs supported (or
not-supported).

"sunXi" would be fine I guess, or "A-series" like suggested on IRC.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/adfff9d0/attachment.sig>
