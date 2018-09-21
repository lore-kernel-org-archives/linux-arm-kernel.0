From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 21 Sep 2018 16:58:29 +0000
Subject: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
In-Reply-To: <f20387e3-4cce-78eb-886c-03ab8c39ae42@gmail.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
 <9461e62248cc7c1b5585004ff8cf7268b823e29c.camel@perches.com>
 <f20387e3-4cce-78eb-886c-03ab8c39ae42@gmail.com>
Message-ID: <1537549106.6513.1.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-08-15 at 18:29 -0700, Florian Fainelli wrote:
> 
> On 08/14/2018 07:16 AM, Joe Perches wrote:
> > On Tue, 2018-08-14 at 16:06 +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > Dynamic debug is really helpful.
> > 
> > It's useful, but perhaps not appropriate.
> > 
> > Most arm configs are for small resource constrained systems.
> 
> Yes, but multi_v*_defconfig, by definition are not, so this really
> seems
> acceptable to me here.

What is the conclusion now? Is anybody gona pull this patchset in? Or
are any changes needed?

> > dynamic_debug adds a lot of additional text and a fair amount of
> > data.
> > 
> > 
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > >  arch/arm/configs/multi_v5_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/configs/multi_v5_defconfig
> > > b/arch/arm/configs/multi_v5_defconfig
> > > index 318b76fa26d1..b302ac68d587 100644
> > > --- a/arch/arm/configs/multi_v5_defconfig
> > > +++ b/arch/arm/configs/multi_v5_defconfig
> > > @@ -275,6 +275,7 @@ CONFIG_NLS_CODEPAGE_850=y
> > >  CONFIG_NLS_ISO8859_1=y
> > >  CONFIG_NLS_ISO8859_2=y
> > >  CONFIG_NLS_UTF8=y
> > > +CONFIG_DYNAMIC_DEBUG=y
> > >  CONFIG_DEBUG_INFO=y
> > >  CONFIG_DEBUG_FS=y
> > >  CONFIG_MAGIC_SYSRQ=y
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
