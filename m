From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 08:23:00 +0000
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <20100326081445.GB20553@pengutronix.de>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003251843320.694@xanadu.home>
	<1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
	<1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
	<20100326081445.GB20553@pengutronix.de>
Message-ID: <20100326082300.GA6665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 09:14:45AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> > I tried to add both,
> > 
> > ftp://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git
> > http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/
> > 
> > and I got strange download failures ..
> It's recommended to have an actual copy of Linus' tree to fetch Russells
> into.  Then it works fine most of the time.

There shouldn't be any problem; that tree is an identical copy of my
local tree which uses no alternatives.  It always contains an entire
set of Linus' tree with no additional repacking.

The only reason to pull this tree into a copy of Linus' tree is that
it'll avoid fetching 400MB or so of Linus' pack files over http from
the UK, instead only fetching 34MB of objects.
