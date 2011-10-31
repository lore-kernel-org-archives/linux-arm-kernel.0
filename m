From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 22:54:24 +0000
Subject: orion/kirkwood and device tree
In-Reply-To: <201110312350.28475.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
	<20111031152100.GR32165@titan.lakedaemon.net>
	<20111031164042.GD29402@lunn.ch>
	<201110312350.28475.michael@walle.cc>
Message-ID: <20111031225424.GC10576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 11:50:28PM +0100, Michael Walle wrote:
> Hi Jason and all,
> 
> Sorry for being quiet such a long time, much work to do here..
> 
> Am Montag 31 Oktober 2011, 17:40:42 schrieb Andrew Lunn:
> > > I wish.  :-)  dreamplug support just made it into u-boot.  So, now I
> > > just have to babysit it until 2011.12 / 2012.01 release.  I should have
> > > some more cycles to dedicate to Linux/dreamplug in the coming months.
> > 
> > Is uboot support necessary? I cannot use jtag on my device, so i'm
> > reluctant to upgrade uboot. I hope it is possible to append the dt to
> > kernel image, at least for development work.
> iirc, i've seen some patches around to add support for appended device trees. 
> dunno if they made it upstream, though.

It was merged during this merge window:

commit b90b9a38251e9c89c34179eccde57411ceb5f1aa
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Sep 13 22:37:07 2011 -0400

    ARM: zImage: allow supplementing appended DTB with traditional ATAG data
