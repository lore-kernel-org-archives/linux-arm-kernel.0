From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 May 2011 09:33:07 +0300
Subject: [GIT PULL] omap updates for 2.6.40
In-Reply-To: <9741DC43-3197-4ECE-A377-FA865A3F6710@dominion.thruhere.net>
References: <20110526113905.GG27250@atomide.com>
	<9741DC43-3197-4ECE-A377-FA865A3F6710@dominion.thruhere.net>
Message-ID: <20110527063304.GA27962@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Koen Kooi <koen@dominion.thruhere.net> [110526 19:02]:
> 
> Op 26 mei 2011, om 13:39 heeft Tony Lindgren het volgende geschreven:
> 
> > Hi Linus,
> > 
> > Please pull omap updates for this merge window from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus
> > 
> > This contains clean-up to shrink down omap specific code a bit. Also included
> > are some fixes. But basically no new code at this point.
> 
> What about updates to board files? Like adding support for the xM rev C to board-omap3beagle.c.

Sorry we're doing only code coalescing and fixes for this merge window as
discussed on LAKML. Otherwise it's hard to see the code coalescing in the
diffstats, so new code will need to wait a bit.

I'll take a look and see if we can justify some fix like trivial patches
like the revision detection patches during the -rc cycle.

Regards,

Tony
