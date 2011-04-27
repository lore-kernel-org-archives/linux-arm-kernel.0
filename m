From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 22:25:42 +0100
Subject: genirq: Generic irq chip available in git
In-Reply-To: <alpine.LFD.2.02.1104231805321.3323@ionos>
References: <alpine.LFD.2.02.1104231805321.3323@ionos>
Message-ID: <20110427212542.GD17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2011 at 06:37:23PM +0200, Thomas Gleixner wrote:
> The generic irq chip infrastructure patches are now available in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip irq/for-arm
> 
> The top commit is cfefd21e693dca791bf9ecfc9dd3794facad533c
> 
> Russell said, he'll pull that into his devel tree, so patches can be
> applied there. SoC maintainers running their own git trees can pull it
> as well so they can apply the patches for their platforms.

Thanks, now pulled into the 'consolidation-irq' branch.  If people
wish to send the per-SoC patches to the patch system, or put them
in their git trees, or indeed whatever, that stuff can be merged
onto that branch so its easier to see where the IRQ consolidation
is at.
