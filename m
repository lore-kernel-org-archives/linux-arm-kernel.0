From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Jan 2014 12:42:59 -0800
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140110183021.GZ2400@pengutronix.de>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140110145444.GE15937@n2100.arm.linux.org.uk>
 <20140110150702.GA22533@kroah.com>
 <20140110151123.GG15937@n2100.arm.linux.org.uk>
 <20140110153530.GA770@kroah.com>
 <20140110183021.GZ2400@pengutronix.de>
Message-ID: <20140110204259.GC10235@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 07:30:21PM +0100, Robert Schwebel wrote:
> On Fri, Jan 10, 2014 at 07:35:30AM -0800, Greg Kroah-Hartman wrote:
> > > I'll sort out a new set of patches today, along with a branch to pull if
> > > you wish to take them that way.
> > 
> > It's too late for 3.14, as my tree is now closed for that because 3.13
> > should be out this weekend.  But I'll be glad to queue them up after
> > 3.14-rc1 is out.
> 
> Didnt' Linus say there would be an -rc8?

Ah, you are right, nevermind then :)

Russell, if you want to send me just the driver core patch, I can take
that now and get that into 3.14 so that you don't have any cross-tree
dependancies on the rest of this patch series.

thanks,

greg k-h
