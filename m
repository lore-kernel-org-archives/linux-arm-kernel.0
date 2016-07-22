From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Jul 2016 00:16:44 -0700
Subject: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
In-Reply-To: <8047226.VhgpLo8JQu@wuerfel>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
 <1469102276-14777-3-git-send-email-kishon@ti.com>
 <8047226.VhgpLo8JQu@wuerfel>
Message-ID: <20160722071644.GZ28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160721 05:08]:
> On Thursday, July 21, 2016 5:27:56 PM CEST Kishon Vijay Abraham I wrote:
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 1a648e9..8e6e2c0 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -86,6 +86,7 @@ config SOC_DRA7XX
> >         select OMAP_INTERCONNECT_BARRIER
> >         select PM_OPP if PM
> >         select ZONE_DMA if ARM_LPAE
> > +       select PCI_DOMAINS if PCI
> >  
> >  config ARCH_OMAP2PLUS
> >         bool
> > 
> 
> Should we just set this unconditionally for ARCH_MULTIPLATFORM maybe?

Makes sense to me if many SoCs need this.

Regards,

Tony
