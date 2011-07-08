From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jul 2011 01:30:42 -0700
Subject: [GIT PULL] omap board updates for v3.1 merge window
In-Reply-To: <201107072240.58987.arnd@arndb.de>
References: <20110707162911.GL5783@atomide.com>
	<201107072240.58987.arnd@arndb.de>
Message-ID: <20110708083042.GQ5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110707 13:36]:
> On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> > Please pull omap board updates from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> > 
> > These are currently on top of the fixes you pulled earlier but
> > could be also rebased on the earlier cleanup if you prefer that.
> 
> I would generally prefer them to be independent, even if that causes
> minor conflicts. If some branches are built on top of others, that
> mainly means I have to remember the order in which to send them
> upstream, and my memory for these things is limited.

Sure. So let's wait on this one a bit. I'll send you some more cleanup
first as I just noticed that the TWL cleanup series will conflict with
these patches.

I need to base these board files on all the cleanup though, otherwise
things will get messy with merge and build conflicts.

Unfortunately there will be dependencies between branches until we
have the driver probe and bus (hwmod) code initializing things
using device tree data..

Regards,

Tony
