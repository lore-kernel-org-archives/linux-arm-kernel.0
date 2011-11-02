From: linux_arm@lakedaemon.net (Jason)
Date: Wed, 2 Nov 2011 12:50:57 -0400
Subject: orion/kirkwood and device tree
In-Reply-To: <201110312350.28475.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
	<20111031152100.GR32165@titan.lakedaemon.net>
	<20111031164042.GD29402@lunn.ch>
	<201110312350.28475.michael@walle.cc>
Message-ID: <20111102165057.GU32165@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael,

On Mon, Oct 31, 2011 at 11:50:28PM +0100, Michael Walle wrote:
> i've already ported some marvell devices to DT. spi-orion, orion-wdt, rtc-mv 
> and mv_cesa. Atm i'm struggling with how to pass kirkwood_mbus_dram_info to 
> the device drivers (the old method is to pass it through platform_data)

Do you have a public git tree I could pull from, by chance?  I don't
care about the state, I'd like to learn by example and start pitching
in.

thx,

Jason.
