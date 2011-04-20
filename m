From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Apr 2011 08:27:21 +0300
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <1303222615.32281.91.camel@deskari>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
	<20110416130929.GL4423@n2100.arm.linux.org.uk>
	<20110418064838.GE12272@atomide.com>
	<1303110011.2062.7.camel@deskari>
	<20110418081743.GH12272@atomide.com>
	<1303222615.32281.91.camel@deskari>
Message-ID: <20110420052718.GA5918@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110419 17:13]:
> Hi Tony and Russell,
> 
> On Mon, 2011-04-18 at 11:17 +0300, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [110418 09:57]:
> 
> > > So, I can make a patch that removes the SRAM support from omapfb, and
> > > queue it up for the next merge window.
> > 
> > OK. That patch should probably go into Russell's tree along with
> > other SRAM related patches to avoid conflicts.
> 
> Here's a simple patch to remove SRAM support from omapfb. Or more
> precisely, this just disables it.
> 
> I started to remove the SRAM support from the drivers, but the patches
> got quite big and will probably cause conflicts if they reside in
> somebody else's tree than mine. So I believe it's easiest to divide SRAM
> FB removal into this patch, handled by Russell (?), and then the rest,
> handled by me.

OK sounds like a plan.
 
> Is there something else related to OMAP FB than the code removed in this
> patch that is hindering the SRAM work?

I think we can now also remove sram_ceil and omap_sram_push_address?

Regards,

Tony
