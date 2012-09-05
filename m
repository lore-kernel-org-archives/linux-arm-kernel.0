From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 16:29:58 -0700
Subject: [PATCH] ARM: OMAP2+: select PINCTRL in Kconfig
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA25D99@DBDE01.ent.ti.com>
References: <1346047244-26909-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA25D99@DBDE01.ent.ti.com>
Message-ID: <20120905232957.GN1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar, Chimata <anilkumar@ti.com> [120903 05:42]:
> Hi Tony,
> 
> On Mon, Aug 27, 2012 at 11:30:44, AnilKumar, Chimata wrote:
> > Select PINCTRL in Kconfig under Typical OMAP configuration, this
> > is required to add pinctrl driver to omap2+ family of devices.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index dd2db02..a164568 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
> >  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> >  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> >  	select HIGHMEM
> > +	select PINCTRL
> >  	help
> >  	  Compile a kernel suitable for booting most boards
> >  
> > -- 
> > 1.7.9.5
> > 
> > 
> 
> If there are no comments on this patch, can you push this patch to devel-dt?

Yes will do, will post first few fixes and support for adding pinctrl-single
controllers for omap2/3/4 that I have here.

Tony
