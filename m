From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Oct 2012 07:10:00 +0200
Subject: Which kirkwood does your DT board use?
In-Reply-To: <alpine.DEB.2.00.1210201305070.10589@marmot.wormnet.eu>
References: <20121020113800.GC21046@lunn.ch>
 <alpine.DEB.2.00.1210201305070.10589@marmot.wormnet.eu>
Message-ID: <20121022051000.GC27355@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> DNS-320:-
> Kirkwood: MV88F6281-A1, TCLK=166666667
> 
> DNS-325:-
> Kirkwood: MV88F6281-A1, TCLK=200000000
> 
> "compatible" currently says "marvell,kirkwood-88f6281" for both. Is
> this the right string to use or should it be 88f6281-a1?

As far as i know, there is no code difference for different stepping
versions of the CPU. So "marvell,kirkwood-88f6281" is good.

	 Thanks
		Andrew
