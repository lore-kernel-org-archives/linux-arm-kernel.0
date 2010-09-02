From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 10:15:02 -0700
Subject: [PATCH 0/6] ARM: Add inline function smp_on_up() for early init
	testing
In-Reply-To: <20100902170830.GW26319@n2100.arm.linux.org.uk>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
Message-ID: <20100902171502.GS11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
> On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> > >From 7044c13594c3023da6095f8d432eda260bc3207f Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 30 Aug 2010 14:00:54 -0700
> > Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
> > 
> > Add inline function smp_on_up() for early init checks, and
> > change build_mem_type_table to use it.
> 
> Isn't something missing from this - such as a C-mode definition of
> SMP() and UP() ?

Oops, here's the missing patch.

Tony
