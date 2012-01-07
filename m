From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 7 Jan 2012 15:50:08 +0100
Subject: Status of arm-soc.git for 3.2
In-Reply-To: <201201062336.31181.arnd@arndb.de>
References: <201201032243.06440.arnd@arndb.de>
 <20120104100016.GK2914@n2100.arm.linux.org.uk>
 <201201062336.31181.arnd@arndb.de>
Message-ID: <20120107145008.GG25978@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 11:36:30PM +0000, Arnd Bergmann wrote:
> On Wednesday 04 January 2012, Russell King - ARM Linux wrote:
> > On Tue, Jan 03, 2012 at 10:43:06PM +0000, Arnd Bergmann wrote:
> > > The merge window is almost there, so it's time to look at what we've queued
> > > up in the arm-soc tree. There is a total of 55 branches with 386 non-merge
> > > changesets on top of mainline and the dependencies (linux-arm, v4l and
> > > dmaengine). The total diffstat is:
> > > 
> > >  676 files changed, 19694 insertions(+), 12633 deletions(-)
> > 
> > Well, my tree looks like this:
> >   937 files changed, 8150 insertions(+), 10774 deletions(-)
> >
> > > I would like to stop adding non-bugfix patches into the branches above now
> > > for 3.2, and instead merge everything that I receive from now on into
> > > late/* branches, so we don't destabilize the patches that are already there
> > > and so I can feel more comfortable about sending everything in the next/*
> > > branches upstream ASAP.
> > 
> > I think that's a must - for both our trees.  We have quite a number of
> > conflicts in linux-next between our trees and other trees - some of them
> > due to duplicated commits being applied.
> 
> Hmm, I'll have to check that, I was hoping that we manged to weed out
> the duplicated commits. Do you have a list, or some (semi-)automated
> way to find those, or are those just random commits you stumbled
> over.
You can look at

	git log --left-right --cherry-mark arm-soc...rmk ^linus/master | grep =

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
