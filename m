From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Nov 2012 08:46:48 +0800
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <201210302141.27919.arnd@arndb.de>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <alpine.LFD.2.02.1210221041450.16518@xanadu.home>
 <20121030074508.GG12329@verge.net.au>
 <201210302141.27919.arnd@arndb.de>
Message-ID: <20121101004647.GA3598@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 09:41:27PM +0000, Arnd Bergmann wrote:
> On Tuesday 30 October 2012, Simon Horman wrote:
> > While I am more than happy to help address the issues raised in this
> > thread, and others that arise. There do seem to be a number of issues
> > between where we are now and a more generic shmobile_defconfig. I would
> > like consideration given to allowing the exixting, working, well-maintained,
> > per-board defconfigs to be updated until these issues have been resolved.
> 
> Yes, no problem. This seemed like a low-hanging fruit initially but has
> turned into something much bigger now.
> 
> Instead of attacking all these at ones, we can leave them as something
> worthwhile doing later. I noticed that out of the 11 shmobile defconfigs,
> only three (marzen, kzm9d and kzm9g) actually have a nonzero MEMORY_START.
> 
> Maybe it's possible to consolidate all or some of the others first, since
> they should still work with the same uImage at the expense of just making
> the early debugging a little harder, as we discussed earlier.
> 
> For all I know, these three boards are also the ones seeing the most
> ongoing development, so you could start by using a shared defconfig
> for the oldest (ARM11 based) boards at first that are also less likely
> to impact new development starting from the defconfig.

Thanks, good observations. I will look into that.

My expectation is that marzen and kzm9g will continue to see
heavy development in the near future.
