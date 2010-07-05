From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 10:15:07 -0400 (EDT)
Subject: Some benchmarks on ARM
In-Reply-To: <20100705134252.GA20855@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
	<alpine.LFD.2.00.1007030136510.32016@xanadu.home>
	<4C31D861.607@gmail.com> <20100705132339.GY20855@pengutronix.de>
	<4C31DEAF.6020205@compulab.co.il>
	<20100705134252.GA20855@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1007051009330.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jul 2010, Robert Schwebel wrote:

> On Mon, Jul 05, 2010 at 04:31:27PM +0300, Mike Rapoport wrote:
> > Native kernel build? ;-)
> 
> Hmm, I don't have a native compiler for all platforms yet.

Kernel compile is a really bad test in this context anyway, unless you 
compile the exact same kernel target using the same config with the SAME 
gcc version on all test machines, and using the same filesystem type and 
medium.

It is best to keep kernel compilation test for validation of 
improvements to a single system.


Nicolas
