From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jul 2018 00:53:46 -0700
Subject: [GIT PULL 5/5] dts changes for omap mcan for v4.19
In-Reply-To: <20180714211925.btxeb3ewlohndsiz@localhost>
References: <pull-1531314878-371161@atomide.com>
 <pull-1531314878-371161@atomide.com-5>
 <20180714211925.btxeb3ewlohndsiz@localhost>
Message-ID: <20180716075346.GS99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [180714 22:21]:
> On Wed, Jul 11, 2018 at 06:19:08AM -0700, Tony Lindgren wrote:
> > dts changes for mcan for omaps for v4.19 merge window
> > 
> > These changes configure the mcan clock, interconnect target
> > module and mcan device. These changes depend on the ti-sysc
> > related driver changes and are based on those.
> > 
> > Notably this is the first new driver that probes with ti-sysc
> > driver with no legacy hwmod platform data for the interconnect
> > target module.
> 
> Hi Tony,
> 
> I'm not entirely sure why you sent this as a separate pull request, but it also
> conflicts with your first DT branch (add/add conflict at the end of the file).

I put them into a separate branch because they were based on
the pending ti-sysc driver changes so you could merge them to
a branch you prefer. But I forgot the merge conflict again..
The resolution is almost always in Linux next for the branches
I send pull requests for for. But I added some notes to check
those next time.

> Fixed up by keeping both sides, merged.

OK thanks!

Tony
