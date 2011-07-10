From: tony@atomide.com (Tony Lindgren)
Date: Sun, 10 Jul 2011 03:17:05 -0700
Subject: [GIT PULL] omap twl cleanup for v3.1 merge window
In-Reply-To: <20110710065537.GD5783@atomide.com>
References: <20110708130102.GB5783@atomide.com>
	<201107081741.23425.arnd@arndb.de>
	<20110710065537.GD5783@atomide.com>
Message-ID: <20110710101705.GF5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110709 23:50]:
> * Arnd Bergmann <arnd@arndb.de> [110708 08:36]:
> > On Friday 08 July 2011, Tony Lindgren wrote:
> > >
> > >I've attached a conflict resolution patch too, it's trivial execpt
> > >note that .vdac needs to be removed in board-rx51-peripherals.c.
> > >
> > >If this conflict causes problems for you, I can also base this series
> > >on omap/board.
> > 
> > The conflict resolution you suggested doesn't build here:
> ...
> 
> > 
> > These are removed in the cleanup series, but changed in the fixes branch,
> > now the removal is undone
> 
> Hmm these are added in omap/board. Maybe the issue is caused by not
> merging omap/board also?

Looks like what got added in in omap/board should now work with the
TWL default values in twl-common.c. So most likely those can just be
dropped. Will check that today.

Regards,

Tony
