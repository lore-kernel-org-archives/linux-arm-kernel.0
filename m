From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 09:22:22 +0100
Subject: genirq: Generic irq chip available in git
In-Reply-To: <20110427212542.GD17290@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1104231805321.3323@ionos>
	<20110427212542.GD17290@n2100.arm.linux.org.uk>
Message-ID: <20110508082222.GA27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 10:25:42PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 23, 2011 at 06:37:23PM +0200, Thomas Gleixner wrote:
> > The generic irq chip infrastructure patches are now available in
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip irq/for-arm
> > 
> > The top commit is cfefd21e693dca791bf9ecfc9dd3794facad533c
> > 
> > Russell said, he'll pull that into his devel tree, so patches can be
> > applied there. SoC maintainers running their own git trees can pull it
> > as well so they can apply the patches for their platforms.
> 
> Thanks, now pulled into the 'consolidation-irq' branch.  If people
> wish to send the per-SoC patches to the patch system, or put them
> in their git trees, or indeed whatever, that stuff can be merged
> onto that branch so its easier to see where the IRQ consolidation
> is at.

I've had nothing further from anyone on this since merging it.  If people
aren't using this stuff then there's no point it sitting in my tree, and
there's no point me sending it to mainline as part of my merges.

So I'm dropping the branch out of the merges for the time being.
