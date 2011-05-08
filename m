From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 8 May 2011 14:35:30 +0100
Subject: genirq: Generic irq chip available in git
In-Reply-To: <20110508082222.GA27807@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1104231805321.3323@ionos>
	<20110427212542.GD17290@n2100.arm.linux.org.uk>
	<20110508082222.GA27807@n2100.arm.linux.org.uk>
Message-ID: <20110508133530.GA13815@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 09:22:22AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 27, 2011 at 10:25:42PM +0100, Russell King - ARM Linux wrote:

> > Thanks, now pulled into the 'consolidation-irq' branch.  If people
> > wish to send the per-SoC patches to the patch system, or put them
> > in their git trees, or indeed whatever, that stuff can be merged
> > onto that branch so its easier to see where the IRQ consolidation
> > is at.

> I've had nothing further from anyone on this since merging it.  If people
> aren't using this stuff then there's no point it sitting in my tree, and
> there's no point me sending it to mainline as part of my merges.

> So I'm dropping the branch out of the merges for the time being.

Would it not make sense to go ahead and apply all the patches that
maintainers already acked?  I rather suspect many people had thought
that Thomas' future pushes of the code would also include the patches
that they'd already approved and haven't realised that they need to
manually push the patches to you.
