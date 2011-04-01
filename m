From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 01 Apr 2011 15:15:14 +0300
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <201104011407.20716.arnd@arndb.de>
References: <201103301906.42429.arnd@arndb.de>
	<201104011322.44729.arnd@arndb.de> <1301658919.27593.72.camel@deskari>
	<201104011407.20716.arnd@arndb.de>
Message-ID: <1301660114.27593.95.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-01 at 14:07 +0200, Arnd Bergmann wrote:
> On Friday 01 April 2011, Tomi Valkeinen wrote:
> > Thanks for pointing me to the MCDE stuff. I doesn't seem to be merged,
> > though. I need to contact them and see if they're still interested in
> > working on the common interface.
> 
> I pushed back quite hard on some of the aspects there, which probably
> prevented it from going in so far. If the code is as much based on
> the OMAP DSS as I think, quite a number of changes are required to
> both in order to get them into shape for a decent cross-platform layer,
> but there should not be any fundamental issues.

I only looked it briefly, but I'm not sure if there's that much code
that could be common. But I need to read the mail thread properly.

The driver for the display HW on the SoC doesn't probably have anything
in common with OMAP one. What could and should be common is the panel
side, which was just a single patch in that patch set.

 Tomi
