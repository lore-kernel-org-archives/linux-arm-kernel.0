From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 13 Nov 2014 10:57:32 +0100
Subject: [PATCH] ARM: at91: remove CONFIG_MACH_SAMA5_DT
In-Reply-To: <20141113095413.GA28756@piout.net>
References: <1415652353-15985-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20141113103425.1cf5e8ea@bbrezillon>
 <20141113095413.GA28756@piout.net>
Message-ID: <20141113105732.283461ad@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Nov 2014 10:54:14 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 13/11/2014 at 10:34:25 +0100, Boris Brezillon wrote :
> > > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > > index 0e6d548b70d9..81ddd7d31d1e 100644
> > > --- a/arch/arm/mach-at91/Kconfig
> > > +++ b/arch/arm/mach-at91/Kconfig
> > > @@ -58,6 +58,7 @@ config SOC_SAMA5
> > >  	select USE_OF
> > >  	select MEMORY
> > >  	select ATMEL_SDRAMC
> > > +	select PHYLIB if NETDEVICES
> > 
> > Is this really related to this commit ?
> > 
> 
> Yes, I simply moved it from CONFIG_MACH_SAMA5_DT to CONFIG_SOC_SAMA5 to
> keep the same functionalities (and probably avoid compilation breakage).
> 
> 

Okay, my bad, I didn't notice it came from the CONFIG_MACH_SAMA5_DT.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
