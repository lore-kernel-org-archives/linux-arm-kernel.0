From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 21:14:27 +0000
Subject: [PATCH 00/33] Restore SA11x0 MCP/UCB drivers to a working state
In-Reply-To: <20120125145420.GC2054@sirena.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
 <20120125145420.GC2054@sirena.org.uk>
Message-ID: <20120125211427.GI1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 02:54:20PM +0000, Mark Brown wrote:
> On Wed, Jan 25, 2012 at 02:30:00PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 20, 2012 at 06:04:56PM +0000, Russell King - ARM Linux wrote:
> 
> > > The following patch set restores the SA11x0 MCP and UCB1x00 drivers back
> > > to a working state, as tested on the Assabet.
> 
> > I've not heard anything back from anyone, so I'm going to assume that's
> > silent approval.
> 
> FWIW Samuel tends to review patches every few weeks to every month, it's
> not unusual for several weeks to patch before things get looked at.

That's not going to be much use - by that time we'll be at -rc4 or so,
which means that reverting the rather large changes becomes much more
of an eye-brow raising request than it would do at -rc1 time.  We're
already at the theoretical dawn of -rc2, one week after -rc1.

So, I think the only thing I can do is push the fixes upstream myself
and hope that Samuel doesn't have an issue with it (he shouldn't have,
as I'm marked in the code as the author of it, and I still have working
hardware to test this stuff on... so in theory I should know what I'm
doing with it!)
