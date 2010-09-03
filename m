From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 3 Sep 2010 17:45:06 +0530
Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-omap
In-Reply-To: <20100902193000.GX11597@atomide.com>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902162337.GP11597@atomide.com>
	<20100902193000.GX11597@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75B0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, September 03, 2010 1:00 AM
> To: Russell King - ARM Linux
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Bryan Wu; Will Deacon
> Subject: Re: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> omap
> 
> * Tony Lindgren <tony@atomide.com> [100902 09:16]:
> > From c04a57fc3b41d886f56ccdc27cf9758de0c95202 Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Tue, 17 Aug 2010 13:33:23 +0300
> > Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> omap
> >
> > Fix SMP on UP interrupt handling for multi-omap
> 
> Here's this one updated to use !smp_cpu() instead of smp_on_up().
> Looks like the description and subject needed some refreshing too.
> 
As I commented on other patch we should just avoid doing anything
When the CPU is not OMAP4. 

Regards,
Santosh
