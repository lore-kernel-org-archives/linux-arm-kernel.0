From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 19 Jul 2011 09:14:54 -0400 (EDT)
Subject: Git pull request: boot_params to atag_offset conversion
In-Reply-To: <20110719074321.GA26574@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1107190042280.21187@xanadu.home>
	<20110719074321.GA26574@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107190834540.21187@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 19, 2011 at 12:55:46AM -0400, Nicolas Pitre wrote:
> > Russell, could you please pull:
> > 
> > 	git://git.linaro.org/people/nico/linux atag_offset
> > 
> > This contains the previously posted patches, plus the collected 
> > Acked-by/Tested-by tags so far.  Since the discussion has died down, I 
> > don't expect further changes.
> > 
> > Alternatively, this can go via the linux-arm-soc tree if you prefer 
> > that.
> 
> Nope, I don't want it to go in this time around - the amount of patches
> you posted last week was _far_ too much for what was billed as the last
> week before the merge window, and by doing so you significantly
> contributed to my stress levels.

I posted those patches on July 5th which was two weeks ago.  I wasn't 
expecting them to go in if the merge window had opened last week. But 
one more week has passed, people tested those patches, they commented 
back, etc.

> I've not been following the discussion on these patches, and don't plan
> to until after the merge window has closed.  Ditto for your other patches.

No problem.  As I said already, those patch series are far from being 
complete yet (i.e. many more similar patches are missing) before they 
can truly make a difference (except maybe for ep93xx).  So this is not 
like if new functionality was held back.

I can't tell if you followed the discussion that ensued or not, 
especially when you were one of the initiators of it.  Without any other 
indication to the contrary, I may only presume that you are OK with the 
set. In any case, just asking to resubmit after the merge window has 
closed is fine with me.

As to being unfair, I don't feel mistreated at all.  I however wouldn't 
like to see you stressed out even when the non core stuff is split away 
from your tree.  Given that ARM is becoming a bigger architecture than 
X86 even at the core stuff alone for which 3 people are sharing the 
maintenance load amongst themselves, I'm a bit concerned that 
scalability issues could wear you out if a backlog starts growing, given 
that more significant core changes are in the pipeline already.  But we 
can discuss this next time we have a beer together.


Nicolas
