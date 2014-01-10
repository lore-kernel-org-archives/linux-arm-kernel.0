From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 10 Jan 2014 19:30:21 +0100
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140110153530.GA770@kroah.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140110145444.GE15937@n2100.arm.linux.org.uk>
 <20140110150702.GA22533@kroah.com>
 <20140110151123.GG15937@n2100.arm.linux.org.uk>
 <20140110153530.GA770@kroah.com>
Message-ID: <20140110183021.GZ2400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 07:35:30AM -0800, Greg Kroah-Hartman wrote:
> > I'll sort out a new set of patches today, along with a branch to pull if
> > you wish to take them that way.
> 
> It's too late for 3.14, as my tree is now closed for that because 3.13
> should be out this weekend.  But I'll be glad to queue them up after
> 3.14-rc1 is out.

Didnt' Linus say there would be an -rc8?

However - there is a devicetree issue to be discussed anyway (see
Sascha's comment). Although we'd personally like to see this series
being merged sooner than later, it should be sorted out first.
Devicetree issues are ugly to change once they are in mainline.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
