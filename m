From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Dec 2010 13:02:48 +0000
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <20101201125339.30270.qmail@stuge.se>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<201011261224.59490.arnd@arndb.de>
	<AANLkTinCYdb8p4-H+Aki-z+i7ZL2ETwGJdDxOQ4XpBJ+@mail.gmail.com>
	<201011301621.48140.arnd@arndb.de>
	<20101130184049.GC8521@n2100.arm.linux.org.uk>
	<20101130184834.GA16055@kroah.com>
	<20101130220550.GD8521@n2100.arm.linux.org.uk>
	<20101130230533.GA11342@kroah.com>
	<20101130234215.GE8521@n2100.arm.linux.org.uk>
	<20101201125339.30270.qmail@stuge.se>
Message-ID: <20101201130248.GA21710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 01:53:39PM +0100, Peter Stuge wrote:
> Russell King - ARM Linux wrote:
> > I feel it would be better to allow the current situation to continue.
> 
> I think this misses the point, and is somewhat redundant; I think
> everyone knows that it is easiest to never change anything. But
> then nothing improves.
> 
> 
> > If we start telling people that they can't use statically declared
> > devices without first having an alternative,
> 
> I would consider it early warning that the way things have been done
> before will go away. And I would thus write drivers in a way that
> demonstrates and includes that understanding.

Clearly you haven't understood my point.

If we go down the route you suggest, we're going to end up with
everyone doing something different, which will then need to be cleaned
up once the proper solution is in place.  That could easily become
much more work than just waiting for the proper solution.

What is easier - to fix all instances which statically declare, or
to fix all instances which statically declare _and_ all the bodged up
alternative solutions?
