From: michael@walle.cc (Michael Walle)
Date: Mon, 7 Nov 2011 00:12:31 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <alpine.LFD.2.02.1111041000060.3307@xanadu.home>
References: <20111031105740.GC29402@lunn.ch>
 <201111032250.59528.michael@walle.cc>
 <alpine.LFD.2.02.1111041000060.3307@xanadu.home>
Message-ID: <201111070012.31804.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag 04 November 2011, 15:01:43 schrieb Nicolas Pitre:
> On Thu, 3 Nov 2011, Michael Walle wrote:
> > yeah i had it there and it should be definitely put back to
> > kirkwood.dtsi. the reason i've put it into lschv2.dts atm is that there
> > is the clock property for every device, which may be different for
> > different platforms.
> 
> The clock property should be a separate entity from the actual devices.
yes of course. the patches above are currently wip. i've only moved the 
property from the platform_data to the dt device entry.

> In fact, that would be a good idea for Kirkwood and friends to move to
> the struck clk API.
yeah i saw that other platforms used that api.


-- 
michael
