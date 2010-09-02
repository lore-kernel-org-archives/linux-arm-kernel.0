From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 09:34:54 -0700
Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
In-Reply-To: <20100902162537.GU26319@n2100.arm.linux.org.uk>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902162039.GM11597@atomide.com>
	<20100902162537.GU26319@n2100.arm.linux.org.uk>
Message-ID: <20100902163453.GR11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 09:18]:
> On Thu, Sep 02, 2010 at 09:20:40AM -0700, Tony Lindgren wrote:
> > >From 253e91b76e104dbdf05c5c3eaf9cbf426972c938 Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Wed, 1 Sep 2010 16:49:13 -0700
> > Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
> > 
> > Fix v7wbi_tlb_flags for SMP on UP. Note that we must enable MULTI_TLB
> > to avoid undefined reference to cpu_tlb error.
> 
> This isn't required, as it is already covered by my patch.

Yup, seems to be working without this patch.

Tony
