From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 07:50:28 +0900
Subject: [PATCH v6 13/17] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
 <1400153532-23675-14-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
Message-ID: <20140515225027.GA29432@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 01:57:58PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, May 15, 2014 at 1:32 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > index 6d6437c..ea7673a 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -9,11 +9,13 @@ CONFIG_EMBEDDED=y
> >  CONFIG_PERF_EVENTS=y
> >  CONFIG_SLAB=y
> >  CONFIG_ARCH_SHMOBILE_MULTI=y
> > +CONFIG_ARCH_R8A7779=y
> >  CONFIG_ARCH_EMEV2=y
> >  CONFIG_ARCH_R8A7790=y
> >  CONFIG_ARCH_R8A7791=y
> >  CONFIG_MACH_KOELSCH=y
> >  CONFIG_MACH_LAGER=y
> > +CONFIG_MACH_MARZEN=y
> >  # CONFIG_SWP_EMULATE is not set
> >  CONFIG_CPU_BPREDICT_DISABLE=y
> >  CONFIG_PL310_ERRATA_588369=y
> 
> I think you also need:
>     CONFIG_SPI_SH_HSPI=y
>     CONFIG_USB_RCAR_PHY=y
>     CONFIG_PM_RUNTIME=y
> 
> (the last one is set in all shmobile defconfigs, except ape6evm and shmobile).
> 
> The other differences seem to be cruft not really related to hardware support.

Thanks, I'll verify that and make a follow-up patch.
