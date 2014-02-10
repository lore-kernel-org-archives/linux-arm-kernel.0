From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Feb 2014 16:19:21 +0100
Subject: [GIT PULL] ARM: imx: device tree changes for 3.15, take 1
In-Reply-To: <20140209121640.GA14588@S2101-09.ap.freescale.net>
References: <20140205122258.GA13821@S2101-09.ap.freescale.net>
 <201402061445.06234.arnd@arndb.de>
 <20140209121640.GA14588@S2101-09.ap.freescale.net>
Message-ID: <201402101619.22124.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 February 2014, Shawn Guo wrote:
> On Thu, Feb 06, 2014 at 02:45:05PM +0100, Arnd Bergmann wrote:
> > On Wednesday 05 February 2014, Shawn Guo wrote:

> > no objections to the stuff you add here, but the way it's organized
> > is not good. Instead of adding the controversial patches first and
> > then reverting them, please redo the series so you don't actually
> > have the patches in the history. I see that you have rebased the
> > patches on 3.14-rc1 already so there really shouldn't be any cross-
> > tree dependencies that make it necessary to keep them in.
> 
> Okay.  I just spent the weekend to rebuild the branch and reworked quite
> a lot of patches to wipe the pingrp stuff from the history.

Thanks!

> > it would be nice to split it up into smaller units. A good
> > separation would be to have new board support in one pull
> > request and the changes to existing boards in another one.
> 
> Some new board support are built on top of the updates to the existing
> files for purpose like sharing common part.  And some updates are added
> on top of new board support along time goes.  So it's hard to make such
> separation.  Considering the amount of imx6 changes these days, I chose
> to split the branch into two, one for imx6 changes and the other for all
> the rest.  Such separation does not involve too much interdependency.

Ok, good idea.

	Arnd
