From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Nov 2014 08:03:52 -0800
Subject: [GIT PULL 1/2] omap non-urgent fixes for v3.19
In-Reply-To: <201411201046.44262.arnd@arndb.de>
References: <pull-1415725783-562282>
 <201411201046.44262.arnd@arndb.de>
Message-ID: <20141120160352.GN7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [141120 01:48]:
> On Tuesday 11 November 2014, Tony Lindgren wrote:
> > ----------------------------------------------------------------
> > Fixes for omap3 that are not urgent. Mostly to remove unnecessary
> > noise during the boot with pointless errors and warnings.
> > 
> 
> 
> Pulled into next/fixes-non-critical. We didn't have any other patches in there,
> so I started out with -rc3 to avoid the back-merge problem. Any reason why
> you didn't base this on -rc1 like the other branches?

I was probably originally planning to have the dmesg warning
and error fixes merged into omap-for-v3.18/fixes branch and
have that automatically fast forward to -rc3 without rebasing.

No other dependency that I can think of.

Regards,

Tony
