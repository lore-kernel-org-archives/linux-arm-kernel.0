From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Dec 2012 08:03:00 -0800
Subject: [GIT PULL] two trivial omap build error fixes for v3.8 merge
 window
In-Reply-To: <20121220155614.GA1034@quad.lixom.net>
References: <20121219171828.GP4989@atomide.com>
 <20121220150105.GA28275@n2100.arm.linux.org.uk>
 <20121220152508.GW4989@atomide.com>
 <20121220155614.GA1034@quad.lixom.net>
Message-ID: <20121220160259.GY4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [121220 07:58]:
> On Thu, Dec 20, 2012 at 07:25:08AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [121220 07:03]:
> > > On Wed, Dec 19, 2012 at 09:18:28AM -0800, Tony Lindgren wrote:
> > > > Here's few more trivial build fixes caused by the merge
> > > > conflicts.
> > > 
> > > If Olof isn't able to pull this stuff in tonight, I'll pull it into my
> > > tree and send it up with my stuff.  I'll also see about picking up
> > > on the previous one with the common.c vram.h fix too.
> > 
> > I just replied to the "[GIT PULL] ARM: arm-soc fixes for 3.8" thread
> > suggesting Linus pull it. It seems that the issue with that one
> > .dts file can easily be fixed later on and there's no need to go
> > tinker with that branch.
> > 
> > Please go ahead and pull in the $Subject: branch though, these two
> > are not yet in Olof's branch.
> > 
> > > I'm not sure what Olof's plans are, but I know Arnd isn't around at
> > > the moment, and Olof was travelling a couple of days ago and hasn't
> > > reappeared since.  I don't think we can leave these fixes any longer
> > > as OMAP has been broken in mainline for at least the last four days
> > > and we're nearing the end of the merge window.
> > 
> > Yes, Olof mentioned that he should be back online within few days.
> > He's probably enjoying the bastu :)
> 
> More like dealing with sick and jetlagged kids, and having issues with
> a decent 3G connection where I'm staying (almost literally in the middle
> of nowhere). It's the first time my current workflow of ssh:ing to my main
> workstation has not worked well, unfortunately.

Welcome back :)
 
> I've redone the sunxi pieces of the fixes branch now, and will apply the other
> recent pull requests and will include those. Since Tony's patches are on
> a branch, if Russell overtakes me and gets his pull request in, there won't be
> any problems caused by it.

Right, those branches are safe to merge into whichever branches
need them.
 
> I'll have a fresh pull request for Linus in an hour or so.

OK, hope my reply to that thread does not confuse things further.

Regards,

Tony
