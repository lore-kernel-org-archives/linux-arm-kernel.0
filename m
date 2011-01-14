From: adi@hexapodia.org (Andy Isaacson)
Date: Thu, 13 Jan 2011 20:22:19 -0800
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294972823.2841.2.camel@heimdal.trondhjem.org>
References: <20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<20110105134045.GS25121@pengutronix.de>
	<1294239193.3014.9.camel@heimdal.trondhjem.org>
	<20110114022554.GA17397@hexapodia.org>
	<1294972823.2841.2.camel@heimdal.trondhjem.org>
Message-ID: <20110114042219.GA17302@hexapodia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 09:40:23PM -0500, Trond Myklebust wrote:
> > My server is running 2.6.36.1, filesystem is ext3 on sda3 on AHCI,
> > client is currently running 2.6.37-rc1.  I'm assuming that 37a09f will
> > fix it.
> 
> Why are you sticking to 2.6.37-rc1 when the final 2.6.37 is out? There
> have been several readdir bugfixes merged in the months since -rc1 came
> out.

No good reason, just hadn't run into any reasons to update; switching
kernels is nonzero cost since the machine in question runs some out of
tree modules ergo updating is slightly more involved than "make && make
install".  Above and beyond the costs of rebooting and losing state.

Actual bug is obviously a good reason to update though.

-andy
