From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 May 2014 19:08:49 -0400
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <8332148.Z1shujgC24@wuerfel>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel>
Message-ID: <20140515230849.GS27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 04:36:35PM +0200, Arnd Bergmann wrote:
> On Thursday 15 May 2014 16:23:41 Andrew Lunn wrote:
> > This is an RFC patchset which removes mach-kirkwood, now that kirkwood
> > support has been converted to DT and lives in mach-mvebu.
> > 
> > It is an RFC because some of the final conversion patches have not yet
> > been accepted by maintainers, in particular:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg328068.html
> > 
> > which needs to be accepted by the Sound/ASoC maintainer.
> > 
> > Once the real patchset is posted, without the RFC status, we would
> > prefer that each subsystem maintainer takes the relevent patches,
> > rather than try to take them all through arm-soc.
> 
> Very nice!
> 
> We had a couple of conflicts in 3.15 between kirkwood and dove both
> getting moved to multiplatform. Any idea how this can be done better
> this time?

Yes, once the changes have matured in -next, I'll merge them into a
single branch to pull instead of separately like I did before.

> There are three other series that may or may not make it into 3.16
> and that will have conflicts with this one:
> 
> - remove mv78xx0
> - remove mach-dove

? I haven't seen anything on these...

> - convert orion5x to multiplatform

I have this one already.

> If we can decide which ones we should have, we can make sure the
> patches correctly build on top of one another or get merged into
> one per subsystem.

hmmm, yes, if only we had some people assigned to do that. ;-)

thx,

Jason.
