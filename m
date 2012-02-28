From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 28 Feb 2012 16:50:19 +0000
Subject: [GIT PULL] DaVinci cleanups for v3.4
In-Reply-To: <201202281527.39302.arnd@arndb.de>
References: <DF0F476B391FA8409C78302C7BA518B6317D2DB9@DBDE01.ent.ti.com>
 <201202271459.52216.arnd@arndb.de>
 <DF0F476B391FA8409C78302C7BA518B6317D6BF8@DBDE01.ent.ti.com>
 <201202281527.39302.arnd@arndb.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317D6ED7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 20:57:39, Arnd Bergmann wrote:
> On Tuesday 28 February 2012, Nori, Sekhar wrote:
> > I guess the cleanest way to do that would have been to let
> > these patches go through my tree with appropriate maintainer
> > acks (but that obviously didn't happen - will try and fix
> > that for future). Per my understanding, it is encouraged that
> > a patch should get applied only through one tree, so I was
> > reluctant to apply them to any of the branches I send to you
> > after they were already in linux-next through other trees.
> 
> That is correct, we generally try to avoid duplicating commits
> but instead use branches that are based on a common history
> containing whatever is needed in multiple places.
> 
> Note that the patch I applied does not duplicate the ones that
> went into the other trees, it recreates dummy header files
> instead and needs to be reverted at some point in the future
> when everything has been merged.

Right. Thanks for taking care of this. Will send a revert once
the dependencies are upstream.

Thanks,
Sekhar
