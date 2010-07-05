From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 5 Jul 2010 15:53:37 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <4C31DEAF.6020205@compulab.co.il>
References: <20100702180257.GA8767@pengutronix.de>
	<20100705132339.GY20855@pengutronix.de>
	<4C31DEAF.6020205@compulab.co.il>
Message-ID: <201007051553.37367.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 5. ?ervence 2010 15:31:27 Mike Rapoport napsal(a):
> Robert Schwebel wrote:
> > Maurus,
> > 
> > On Mon, Jul 05, 2010 at 03:04:33PM +0200, Maurus Cuelenaere wrote:
> >> Some quick tests of lmbench on a Sheevaplug:
> > Thanks a lot - we'll update the document soon, wiht the exact command
> > lines included.
> > 
> >> I'm not sure if I'm doing this right, but it looks like the Sheevaplug
> >> beats all ARM chips (except on FP) on the tests done at [1]. Looks
> >> like these tests heavily depend on the clock frequency.
> > 
> > If anyone has an idea for better benchmarks, I'd be very interested. We
> > have been searching for benchmarks which:
> > 
> > - can be easily cross compiled to all involved platforms
> > - show the different aspects of the systems
> 
> Native kernel build? ;-)

about 7 hours on xscale-pxa270 with 256MB of SDRAM ... compiling all xscale 
platforms in :)

> 
> > rsc
