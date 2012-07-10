From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 10 Jul 2012 12:24:48 +0100
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710094249.GF10225@elf.ucw.cz>
References: <20120710094249.GF10225@elf.ucw.cz>
Message-ID: <20120710112448.GA4806@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 11:42:50AM +0200, Pavel Machek wrote:
> Hi!
> 
> It seems mach-socfpga (not yet in tree, we are trying to merge it)
> would need pretty much direct copy of arch/arm/mach-picoxcell/time.c
> ... And because "just copying" it seems like quite bad idea, what
> about this, instead?

Sure, sounds like a great plan!  I'd agree with Thomas about creating a 
config option for this.  We'll also need the appropriate binding 
documentation (probably just moving and rewording the picoxcell timer 
binding docs).

If you could add the picoxcell compatible strings then we can avoid the 
dts churn.

Jamie
