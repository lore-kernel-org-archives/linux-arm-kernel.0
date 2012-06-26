From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jun 2012 19:34:42 +0100
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <1340642293.1562.59.camel@vkoul-udesk3>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <1340642293.1562.59.camel@vkoul-udesk3>
Message-ID: <20120626183442.GA27261@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 10:08:13PM +0530, Vinod Koul wrote:
> Hi Russell,
> 
> What is the status of the virtual dma and the series you have posted
> previously. Is it ready for merge?
> 
> I would be away for 10days starting coming Thursday. So please let me
> know

I have no idea.

I've just rebased all the DMA stuff onto -rc4, because -rc3 is just a
whole load of problems for OMAP, and I'm still struggling with the
stupid OMAP audio crap.  And what with people who know how the SDP4430
works and/or OMAP audio works going on holiday too, I don't see much
progress being made until August time.

I've found that the only way I can get any audio out of the SDP4430
platform is if I have something connected to the 3.5mm jack before
powering up the board, and keep it connected.  So provided I do that
I can test the OMAP audio stuff.

Of course, finding out crap like that takes time away from my _one_
day a _week_ that I'm working on OMAP stuff...
