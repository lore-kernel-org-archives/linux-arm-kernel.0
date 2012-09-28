From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Sep 2012 15:21:40 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API v2
In-Reply-To: <20120928131530.GG7916@n2100.arm.linux.org.uk>
References: <20120928092123.GA28967@e102568-lin.cambridge.arm.com>
 <20120928125446.GF7916@n2100.arm.linux.org.uk>
 <20120928131254.GB30058@e102568-lin.cambridge.arm.com>
 <20120928131530.GG7916@n2100.arm.linux.org.uk>
Message-ID: <20120928142140.GD30058@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 02:15:30PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 28, 2012 at 02:12:54PM +0100, Lorenzo Pieralisi wrote:
> > Ok, understood, sorry. What's the best way forward then ?
> > 
> > Should I add the fix for xscale and feroceon to your patch system ?
> 
> That's one solution, and probably the best as it means less commits in
> the end.

Done, 7542/1, applied and tested on top of your current devel-stable.

It does solve linux-next build issues for Orion5, Kirkwood and mv78xx0
caused by missing feroceon_range_flush_kern_cache_louis alias.

My apologies, thanks.
Lorenzo
