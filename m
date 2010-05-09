From: will.deacon@arm.com (Will Deacon)
Date: Sun, 09 May 2010 10:33:44 +0100
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <20100507181543.GC7887@n2100.arm.linux.org.uk>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
	<20100507181543.GC7887@n2100.arm.linux.org.uk>
Message-ID: <1273397624.1865.3.camel@e200755-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, 2010-05-07 at 19:15 +0100, Russell King - ARM Linux wrote:
> 
> My intention is as follows:
> 
> 1. Freeze the multiple branches with patches next week.
> 2. Apply your patches on top of the merged-set of those branches.
> 3. Apply the other pending patches which are dependent on these
> branches.
> 
> Now, at that point, the devel-stable branch won't merge cleanly back
> into devel because of this MSM problem, and the problem is how do we
> solve that.
> 
Thanks for explaining this, I was getting a bit confused by the various
branches and just trying to avoid any conflicts. Now that the MSM patch
has been reverted [thanks Daniel] the original PMU registration patch
should apply. I've updated the patch system accordingly [discarding
6113/1 and moving 6064/1 from superseded to incoming].

Once this lot is in, we can think about MSM support then.

Thanks,

Will
