From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Jul 2010 20:30:06 +0100
Subject: [FAILED] BLD phyCORE-i.MX31 + linux-next git kernel
In-Reply-To: <20100717191745.GC30077@pengutronix.de>
References: <E1OZs5K-0005Px-5r@himalia.hi.pengutronix.de>
	<20100717191745.GC30077@pengutronix.de>
Message-ID: <20100717193006.GA14791@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 17, 2010 at 09:17:45PM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> Our nightly built found a problem while working on linux-next.
> Commit v2.6.35-rc5-17-g6f7dd68 broke your devel branch
> by renaming lmb to memblock.

Yes, sfr and Mark Brown mentioned it yesterday.  I fixed it yesterday,
but it's going to be until Monday-ish before linux-next gets sorted
(sfr is one of the sane folk who has weekends off!)
