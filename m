From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Jun 2010 18:31:56 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <4C0818F9.9070008@bluewatersys.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<4C0818F9.9070008@bluewatersys.com>
Message-ID: <alpine.LFD.2.00.1006031829020.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jun 2010, Ryan Mallon wrote:

> Is it worth being a bit proactive and getting rid of some of them in
> advance? Things like spear3[012]0_defconfig are basically identically
> except for the board type. Combining all three of those would remove
> 1500 lines of code.

Please go ahead with a patch.

> Basically reduce down to one or two defconfigs for each mach directory
> which include as many boards and drivers as possible. People wanting
> more tailored configs can do that in their own trees.

This actually should have been the plan from the start.  See for example 
orion5x_defconfig which currently already supports 23 machines.


Nicolas
