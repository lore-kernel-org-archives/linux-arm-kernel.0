From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 08:03:54 +0000
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121012092617.37e82610@skate>
References: <20121007015300.828366635@gmail.com>
 <20121012070651.GA17511@glitch> <20121012092617.37e82610@skate>
Message-ID: <201210120803.54539.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 October 2012, Thomas Petazzoni wrote:
> My understanding is that all virtual address constants should now be
> defined to have the void __iomem * type (i.e, using IOMEM). In the
> future, the idea is that map_desc.virtual might be switched to the void
> __iomem * type as well.
> 
> But others (Arnd?) will confirm (or not) this.

I would certainly like to see this, yes. I had a patch for it ages ago,
but would start over again if I did this now.

I don't have time to do the conversion at the moment, but I would certainly
welcome a patch that does it. I can give some details about the problems
with that and how I think they should be solved.

	Arnd
