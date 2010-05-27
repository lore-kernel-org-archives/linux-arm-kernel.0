From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 27 May 2010 12:47:06 +0300
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100527092501.GA28112@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100522215848.GB29889@n2100.arm.linux.org.uk>
	<20100526004418.GM9645@atomide.com>
	<20100526075059.GA25435@n2100.arm.linux.org.uk>
	<20100526135128.GN9645@atomide.com>
	<20100526214037.GB16418@n2100.arm.linux.org.uk>
	<1274950338.2265.134.camel@tubuntu.research.nokia.com>
	<20100527092501.GA28112@n2100.arm.linux.org.uk>
Message-ID: <1274953626.2265.196.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-27 at 11:25 +0200, ext Russell King - ARM Linux wrote:
> On Thu, May 27, 2010 at 11:52:18AM +0300, Tomi Valkeinen wrote:

> > I tested your lmb branch on OMAP 3430SDP board, and after removing the
> > topmost patch (ARM: use LMB to allocate system memory MMIO resource
> > structures) everything related to DSS2 (drivers/video/omap2/) seemed to
> > work ok.
> 
> Great, can I add your tested-by for the OMAP and LMB stuff up to but not
> including the last commit?

Sure.

I'll also try to find time to review the DSS side changes properly.

 Tomi
