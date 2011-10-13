From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 10:59:15 +0100
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <20111013090609.GT577@pengutronix.de>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192621.GA28049@pengutronix.de>
	<20111008220722.GG25689@n2100.arm.linux.org.uk>
	<20111013090609.GT577@pengutronix.de>
Message-ID: <20111013095915.GO21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 11:06:09AM +0200, Uwe Kleine-K?nig wrote:
> On Sat, Oct 08, 2011 at 11:07:22PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Oct 08, 2011 at 09:26:21PM +0200, Wolfram Sang wrote:
> > > On Sat, Oct 08, 2011 at 05:19:48PM +0200, Gwenhael Goavec-Merou wrote:
> > > > 
> > > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > > 
> > > I think this file is maintained by Russell, yet I want to ack that the entry
> > > below is missing for building mx1_defconfig. Found that, too.
> > 
> > The thing is - read the comments at the top of the file.  There's hints
> > there as to what will happen if you patch the file.  The hint is
> > 'automatically generated'.  So when I next update the file, any patches
> > done to the file will be wiped out.
> Currently the id is still missing in your for-next branch and it is
> marked as "mainlined" on http://www.arm.linux.org.uk/developer/machines/
> (906).
> 
> That means that the next update should include the id, right?

Not if it's a buggered entry - which it doesn't appear to be.  The problem
is that now that I've stopped manually editing out the buggered entries,
favouring doing it automatically, any update to the file ends up breaking
the damned thing for someone.

It's rather too late in the cycle for me to commit an update now - I
suspect doing so will upset a lot of people.
