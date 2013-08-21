From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 00:55:01 -0700
Subject: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option description
In-Reply-To: <20130820164251.GC4889@localhost>
References: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABxcv=keV2Jf4gDwF477a9Msk6b-RgDBcxK1QyhchWffbKAoXw@mail.gmail.com>
 <20130820164251.GC4889@localhost>
Message-ID: <20130821075501.GY7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [130820 09:49]:
> On Fri, Aug 09, 2013 at 11:18:43AM +0200, Javier Martinez Canillas wrote:
> > On Thu, Aug 8, 2013 at 11:32 PM, Ezequiel Garcia
> > <ezequiel.garcia@free-electrons.com> wrote:
> > > Fix the option description to match the other TI SoCs.
> > > This is just a cosmetic change.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-omap2/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index 76170dd..56021c6 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -64,7 +64,7 @@ config SOC_OMAP5
> > >         select ARM_ERRATA_798181 if SMP
> > >
> > >  config SOC_AM33XX
> > > -       bool "AM33XX support"
> > > +       bool "TI AM33XX"
> > >         depends on ARCH_MULTI_V7
> > >         select ARCH_OMAP2PLUS
> > >         select ARM_CPU_SUSPEND if PM
> > > --
> > > 1.8.1.5
> > >
> > >
> > 
> > Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> ping?

Applying to omap-for-v3.12/fixes-non-critical thanks.

Tony
