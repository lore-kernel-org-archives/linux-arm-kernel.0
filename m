From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Feb 2011 10:36:02 -0800
Subject: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
	DEBUG_LL
In-Reply-To: <20110204171526.GA8821@n2100.arm.linux.org.uk>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
	<20110204012709.26410.78100.stgit@baageli.muru.com>
	<alpine.LFD.2.00.1102032205140.12104@xanadu.home>
	<20110204171526.GA8821@n2100.arm.linux.org.uk>
Message-ID: <20110204183602.GW3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110204 09:14]:
> 
> The other point to make is that for every machine in OMAP1, the
> serial port is located at 0xffXXXXXX virtual, 0xfeXXXXXX physical.
> For OMAP2, that's 0xfaXXXXXX virtual and 0x48XXXXXX physical.
>
> So it's pointless storing both the virtual and physical addresses
> as we can compute one from the other with a single instruction.
> That gets rid of some of the complexity found in the debugging code.

OK. The zoom boards have external 8250 on the GPMC bus.

Tony
