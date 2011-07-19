From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 16:20:15 +0100
Subject: Git pull request: boot_params to atag_offset conversion
In-Reply-To: <alpine.LFD.2.00.1107190834540.21187@xanadu.home>
References: <alpine.LFD.2.00.1107190042280.21187@xanadu.home>
	<20110719074321.GA26574@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107190834540.21187@xanadu.home>
Message-ID: <20110719152015.GA308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 09:14:54AM -0400, Nicolas Pitre wrote:
> As to being unfair, I don't feel mistreated at all.  I however wouldn't 
> like to see you stressed out even when the non core stuff is split away 
> from your tree.  Given that ARM is becoming a bigger architecture than 
> X86 even at the core stuff alone for which 3 people are sharing the 
> maintenance load amongst themselves, I'm a bit concerned that 
> scalability issues could wear you out if a backlog starts growing, given 
> that more significant core changes are in the pipeline already.  But we 
> can discuss this next time we have a beer together.

What I'm concerned about is the lack of regard for where we are in the
cycle.

First, the week before a merge window _should_ be used for:
1. for people to settle down their trees
2. publish what they're intending to merge during the next window
3. testing what's been merged to make sure that it is suitably robust

It should not be for posting large patch series for changes which have
not been previously seen.

If you think throwing more people this will solve it, you're missing the
issue.  The reason it's caused me a problem this time around is precisely
because we have more people, and I _have_ to look at them and say no,
otherwise they'll find some other route in.  So actually, I'm now not
able to simply ignore stuff.
