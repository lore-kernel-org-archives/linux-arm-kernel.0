From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 11 May 2011 23:15:57 +0530
Subject: genirq: Generic irq chip available in git
In-Reply-To: <20110508140344.GC15968@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.02.1104231805321.3323@ionos>
	<20110427212542.GD17290@n2100.arm.linux.org.uk>
	<20110508082222.GA27807@n2100.arm.linux.org.uk>
	<20110508133530.GA13815@opensource.wolfsonmicro.com>
	<20110508140023.GK27807@n2100.arm.linux.org.uk>
	<20110508140344.GC15968@opensource.wolfsonmicro.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CE66709@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, May 08, 2011 at 19:33:45, Mark Brown wrote:
> On Sun, May 08, 2011 at 03:00:23PM +0100, Russell King - ARM Linux wrote:
> > On Sun, May 08, 2011 at 02:35:30PM +0100, Mark Brown wrote:
> 
> > > Would it not make sense to go ahead and apply all the patches that
> > > maintainers already acked?  I rather suspect many people had thought
> > > that Thomas' future pushes of the code would also include the patches
> > > that they'd already approved and haven't realised that they need to
> > > manually push the patches to you.
> 
> > Which involves me having to read through the entire thread yet again to
> > figure out what state each patch is at, save them out, edit them to add
> > each ack to relevant patches, copy the lot to another machine, and then
> > apply them.
> 
> > The workload there is on the wrong person.
> 
> Yeah, I'd actually have expected Thomas to have done this when he pushed
> the patches to you to be honest - certainly if I were one of the
> relevant maintainers I'd have been surprised that the patches got
> dropped.

I have included Thomas's davinci platform update with the relevant
acks in the following pull request. There was also a checkpatch
error that I fixed up locally. Hope this helps.

The following changes since commit cfefd21e693dca791bf9ecfc9dd3794facad533c:
  Thomas Gleixner (1):
        genirq: Add chip suspend and resume callbacks

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git irq-davinci

Thomas Gleixner (1):
      arm: davinci: Use generic irq chip

 arch/arm/mach-davinci/irq.c |   93 +++++++++---------------------------------
 1 files changed, 20 insertions(+), 73 deletions(-)
