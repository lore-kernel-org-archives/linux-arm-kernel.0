From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 10:25:01 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <1274950338.2265.134.camel@tubuntu.research.nokia.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100522215848.GB29889@n2100.arm.linux.org.uk>
	<20100526004418.GM9645@atomide.com>
	<20100526075059.GA25435@n2100.arm.linux.org.uk>
	<20100526135128.GN9645@atomide.com>
	<20100526214037.GB16418@n2100.arm.linux.org.uk>
	<1274950338.2265.134.camel@tubuntu.research.nokia.com>
Message-ID: <20100527092501.GA28112@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 11:52:18AM +0300, Tomi Valkeinen wrote:
> On Wed, 2010-05-26 at 23:40 +0200, ext Russell King - ARM Linux wrote:
> > On Wed, May 26, 2010 at 06:51:29AM -0700, Tony Lindgren wrote:
> 
> > > Yeah I'll do that once the dss2 code has been verified to work.
> > 
> > It'd help with this patch - it seems rx51 needs some additional stuff.
> > Any other OMAP platforms with this kind of thing?
> 
> I think rx51 is currently the only board that configures the VRAM size
> dynamically at boot time.
> 
> I tested your lmb branch on OMAP 3430SDP board, and after removing the
> topmost patch (ARM: use LMB to allocate system memory MMIO resource
> structures) everything related to DSS2 (drivers/video/omap2/) seemed to
> work ok.

Great, can I add your tested-by for the OMAP and LMB stuff up to but not
including the last commit?
