From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 12:44:27 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <1279798823.9564.47.camel@e102109-lin.cambridge.arm.com>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
	<20100722103038.GE31293@n2100.arm.linux.org.uk>
	<1279796069.9564.2.camel@e102109-lin.cambridge.arm.com>
	<20100722105729.GK31293@n2100.arm.linux.org.uk>
	<1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
	<20100722111631.GM31293@n2100.arm.linux.org.uk>
	<1279797596.9564.25.camel@e102109-lin.cambridge.arm.com>
	<20100722113003.GN31293@n2100.arm.linux.org.uk>
	<1279798823.9564.47.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100722114427.GP31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:40:23PM +0100, Catalin Marinas wrote:
> On Thu, 2010-07-22 at 12:30 +0100, Russell King - ARM Linux wrote:
> > It's also an argument for avoiding DT!  If boot loaders can't even get
> > the most basic of information right...
> 
> With DT I see it as slightly different. The DT information is provided
> by the board manufacturer and the boot loader doesn't need to do much
> discovery. It can be a pretty dumb boot loader just passing the relevant
> DT address to the kernel. But that's another thread of discussion (which
> unfortunately I didn't have time to follow properly).

The boot loader is also provided by the board manufacturer...  I see it
as being not much different.
