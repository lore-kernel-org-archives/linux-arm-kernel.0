From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 10:52:58 -0700
Subject: [GIT PULL 2/3] omap timer changes for v3.10 merge window
In-Reply-To: <201304081936.56288.arnd@arndb.de>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
 <201304081936.56288.arnd@arndb.de>
Message-ID: <20130408175257.GT10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130408 10:41]:
> On Thursday 04 April 2013, Tony Lindgren wrote:
> > Clean-up for omap2+ timers from Jon Hunter <jon-hunter@ti.com>:
> > 
> > This series consists mainly of clean-ups for clockevents and
> > clocksource timers on OMAP2+ devices. The most significant change
> > in functionality comes from the 5th patch which is changing the
> > selection of the clocksource timer for OMAP3 and AM335x devices
> > when gptimers are used for clocksource.
> > 
> > Note that this series depends on 7185684 (ARM: OMAP: use
> > consistent error checking) in RMK's tree and 960cba6 (ARM:
> > OMAP5: timer: Update the clocksource name as per clock data)
> > in omap-for-v3.10/fixes-non-critical. So this branch is based
> > on a merge of 7185684 and omap-for-v3.10/fixes-non-critical
> > to avoid non-trivial merge conflicts.
> > 
> 
> Pulled into next/drivers, thanks!
> 
> Do you have a URL for a stable branch containing 7185684
> that we can list in our branch description file?

That's in RMK's for-next, but I have not seen any discussion
for that branch being immutable except up to commit 7185684.

Unless Russell has better ideas, you may want to set up
branch with 7185684 as the head for your dependencies.

Regards,

Tony
