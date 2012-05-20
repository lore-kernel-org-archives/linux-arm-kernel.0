From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 May 2012 15:22:14 +0200
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
 <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
Message-ID: <20120520132214.GD12741@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I should really submit this :) What should it be based on? A new
> revision of my previous patches, or should I assume that my work and
> Andrew's clk work have already been merged? (apologies if this is a
> dumb question)

Yes, you can assume both are in. arm-soc has them, so the 3.5-rc1
should have them.

For the next cycle we need to improve working together on DT porting.
There is a lot of work going on here, in kirkwood, orion5x, dove, and
the two new Armada SoCs, all needing/porting drivers to DT.  I think
we need a tree where patches are quickly added once they are stable,
so that others can profit from the work.

       Andrew
