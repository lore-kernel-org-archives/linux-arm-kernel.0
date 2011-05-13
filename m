From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 13 May 2011 17:53:54 +0300
Subject: Updated mach-types update
In-Reply-To: <20110513115406.GQ31483@atomide.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110320114137.GD16646@n2100.arm.linux.org.uk>
	<20110324175945.GV2811@atomide.com>
	<20110513115406.GQ31483@atomide.com>
Message-ID: <1305298434.2268.53.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-13 at 04:54 -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110324 10:57]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
> > > On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
> > > 
> > > Note that OMAP references machine_is_omap2evm() yet this has never been
> > > merged.
> > > 
> > > arch/arm/plat-omap/include/plat/uncompress.h:
> > > 
> > >                 DEBUG_LL_OMAP2(1, omap2evm);
> > > 
> > > so this entry needs to be removed.
> > 
> > Hmm looks like we have LCD support and ASoC support for it, but no
> > board :)
> > 
> > Anybody working with this board?
> > 
> > If so, please send patches for the related board-*.c support ASAP.
> > Otherwise let's plan on deleting the related support.
> 
> No patches, so let's remove it. Here's the patch to do that,
> I'm planning to add this to my devel-cleanup branch.

For removing the lcd driver:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi
