From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 10:46:49 -0700
Subject: [GIT PULL 2/3] omap timer changes for v3.10 merge window
In-Reply-To: <201304081940.12773.arnd@arndb.de>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
 <201304081940.12773.arnd@arndb.de>
Message-ID: <20130408174648.GS10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130408 10:45]:
> On Thursday 04 April 2013, Tony Lindgren wrote:
> >  arch/arm/mach-omap2/board-cm-t3517.c |   2 +-
> >  arch/arm/mach-omap2/board-generic.c  |   2 +-
> >  arch/arm/mach-omap2/common.h         |   3 +-
> >  arch/arm/mach-omap2/timer.c          | 124 ++++++++++++++++++-----------------
> >  4 files changed, 66 insertions(+), 65 deletions(-)
> 
> BTW, do you have any plans to move the timer.c file to drivers/clocksource?
> 
> I think that's where most of them are heading now.

Yes that's the plan.

With the various patches posted at least the timer code
GPMC code should be very close to being movable. And the
mailbox code is getting moved to drivers based on the pull
request I saw for that few days ago.

Regards,

Tony
