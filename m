From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 21 May 2012 11:39:22 -0400
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120521094052.GA22191@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
 <20120518191832.GC24238@titan.lakedaemon.net>
 <201205182044.26409.arnd@arndb.de>
 <4FBA030F.4050101@codethink.co.uk> <20120521091615.GD14362@lunn.ch>
 <4FBA0A83.1030201@codethink.co.uk> <20120521094052.GA22191@lunn.ch>
Message-ID: <20120521153922.GO24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 11:40:52AM +0200, Andrew Lunn wrote:
> > Personally, my view is leave it alone and just add a new machine
> > directory.

I agree, see my response to Russell.

> > Pushing items around doesn't really help the amount of code in the
> > kernel, the organisation does not add more than a line or two to the
> > Makefiles.
> 
> It does however make it easier to see where the same code has been
> cut/paste. There is some stuff in the various Orion mach- directories
> which is repeated 4 times. The Armada XP port wanted to add a 5th
> copy. All this repeated code needs to be put into plat-orion.

Does my suggested layout/migration path cover your concerns?

thx,

Jason.
