From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 24 Sep 2011 01:36:31 -0600 (MDT)
Subject: [PATCH 0/8] OMAP3/4: Misc fixes and clean-up
In-Reply-To: <4E7D7A28.3070005@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<4E7D72BF.8060009@ti.com>
	<alpine.DEB.2.00.1109240031280.22872@utopia.booyaka.com>
	<4E7D7A28.3070005@ti.com>
Message-ID: <alpine.DEB.2.00.1109240120240.22872@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, 24 Sep 2011, Santosh Shilimkar wrote:

> On Saturday 24 September 2011 12:01 PM, Paul Walmsley wrote:
> > Hi Santosh
> > 
> > On Sat, 24 Sep 2011, Santosh Shilimkar wrote:
> > 
> >> On Thursday 08 September 2011 10:51 AM, Santosh Shilimkar wrote:
> >>>
> >> I need your ack on below two patches so that I can re-base them and
> >> send a pull request to Tony.
> >>
> >> OMAP4: clock: Add CPU local timer clock node.
> >> OMAP: Fix sparse warnings in l3 error handler.
> > 
> > Are you targeting these for 3.1-rc ?
> > 
> Nope. It's for 3.2 merge window.
> As such, the series doesn't have any major regression
> fixes which should make it before 3.2

In that case, patches 1 and 7 should go in through me.  The rest should go 
via Tony.  So you can just drop 1 and 7 from your branch, I'll pull those 
off the list. 

Some comments though:  Looks like you need to repost patch 1 due to 
comments from Beno?t?  Also, have the autogeneration scripts been updated 
for patch 7?

...

As far as patch 5 goes, you don't need my ack on that one, since I'm not 
the maintainer or original author of that code.  But feel free to add a 
Reviewed-by:.  I also tested the two L3 files with sparse and they are 
clean now.  Thanks very much for taking the initiative on this; I 
personally appreciate it quite a bit, and I think having clean code 
increases our credibility with upstream maintainers. 


- Paul
