From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 18 Oct 2012 20:27:32 +0200
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
Message-ID: <20121018182732.GC2350@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 03:46:15AM +0000, Paul Walmsley wrote:
> 
> It doesn't necessarily mean that the driver is usable in that kernel 
> release.

Well, it should. We have staging for half-baked stuff.

> Either way, the patch is likely to make it into the mainline kernel.  
> It's just that it will probably take a few weeks longer than you might 
> like.

I don't mind waiting for a driver that is held off because of missing
background support.

I *do* mind if y'all go merging all kinds of code that has never been
tested. Those who submit and their reviewers should ensure that the
code is actually working. Before buying hardware or starting projects,
I often check what is in mainline. I expect that mainline has been at
least minimally tested.

Maybe that is just me, or maybe people working on the ARM tree have
different expectations.

Thanks,
Richard
