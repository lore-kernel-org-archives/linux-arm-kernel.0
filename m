From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 2 Jun 2014 11:35:03 +0200
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <20140602092913.GA933@n2100.arm.linux.org.uk>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140602092913.GA933@n2100.arm.linux.org.uk>
Message-ID: <20140602093503.GA24919@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 10:29:13AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 02, 2014 at 11:21:02AM +0200, Antoine T?nart wrote:
> > diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> > index d3c5f14dc142..e3733692f67a 100644
> > --- a/arch/arm/mach-berlin/Kconfig
> > +++ b/arch/arm/mach-berlin/Kconfig
> > @@ -4,6 +4,7 @@ config ARCH_BERLIN
> >  	select GENERIC_IRQ_CHIP
> >  	select DW_APB_ICTL
> >  	select DW_APB_TIMER_OF
> > +	select SMP
> 
> Please don't add selects of symbols which aren't absolutely necessary.
> 
> Since this has been merged without SMP support and presumably works without
> SMP support, it would appear that SMP support is not mandatory for the
> platform to work.

It can work without SMP, I'll remove this.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
