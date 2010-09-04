From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 4 Sep 2010 16:31:06 +0530
Subject: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
In-Reply-To: <20100904105750.GC12674@n2100.arm.linux.org.uk>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161940.GL11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7588@dbde02.ent.ti.com>
	<20100904105750.GC12674@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE77A2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, September 04, 2010 4:28 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Bryan Wu; Will Deacon
> Subject: Re: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
> 
> On Fri, Sep 03, 2010 at 05:27:25PM +0530, Shilimkar, Santosh wrote:
> > Since UP/SMP both cases are handled, the above patch can be something
> > like this now...
> 
> No - this results in the instruction used for ARMv6 SMP systems being
> changed to the ARMv7 instruction, which probably won't work.
Ok. I get it now
