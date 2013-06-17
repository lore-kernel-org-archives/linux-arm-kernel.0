From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 14:20:05 +0100
Subject: [GIT PULL] arm: arch_timer cleanups and niceties for 3.11
In-Reply-To: <20130611100457.GB22334@e106331-lin.cambridge.arm.com>
References: <20130607173902.GJ23311@e106331-lin.cambridge.arm.com>
 <20130611100457.GB22334@e106331-lin.cambridge.arm.com>
Message-ID: <20130617132005.GF2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 11:04:57AM +0100, Mark Rutland wrote:
> On Fri, Jun 07, 2013 at 06:39:02PM +0100, Mark Rutland wrote:
> > Hi Russell,
> > 
> > Please pull these arch_timer cleanups I've been holding onto for a while.
> > They're the same as my last posting [1], but have been rebased to v3.10-rc3.
> > 
> > Thanks,
> > Mark.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170602.html
> 
> It looks like there was a final ARM_ARCH_TIMER select in multi_v7_defconfig
> that's causing architected timer support to not get selected, which the patch
> below should fix if appended to the series. I've grepped for ARM_ARCH_TIMER,
> and it looks like it's the the last remaining occurence.

So what do you want to do with this?  Is it needed to be included in your
set of patches in your pull request?

And I think I remember seeing some other patches related to this change
too...
