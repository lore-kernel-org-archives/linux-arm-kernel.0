From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 13:47:24 -0800
Subject: [GIT PULL] omap fixes for v3.2 merge window breakage
In-Reply-To: <20111107212919.GI15294@n2100.arm.linux.org.uk>
References: <20111107204929.GZ31337@atomide.com>
 <20111107212919.GI15294@n2100.arm.linux.org.uk>
Message-ID: <20111107214724.GA31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 12:54]:
> Arnd,
> 
> Don't pull this - there's yet more crap in OMAP to be fixed before
> these go to mainline.  OMAP3 is severely broken at the moment with,
> to put it bluntly, totally fucked up OMAP hwmod code, and should be
> fixed *now* by folk before this pull request.
> 
> The fixes are damned trivial I expect even Tony can fix it without
> reference to Paul.

> >       ARM: OMAP3: hwmod: fix variant registration and remove SmartReflex from common list

Sounds like the above patch already queued should fix the issues you
are seeing with hwmod?

Or do you still have other issues you're having?

Tony
