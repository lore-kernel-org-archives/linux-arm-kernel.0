From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 09:30:58 -0400 (EDT)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <20130405094159.GH17995@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <20130328134808.GD16765@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1304022258430.1171@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
 <20130405094159.GH17995@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304050854590.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Russell King - ARM Linux wrote:

> Right, you force my hand.  None of the stuff below should be public, but
> you give me no choice now but to publically defend myself against your
> allegations.
> 
> The reason that I haven't merged it is that:
> 
> 1. At the beginning of December, when the TI situation looked very
>    uncertain, I approached Linaro to see whether it was possible to
>    sort out a relationship with them.  Linaro were enthusiastic.
> 
> 2. It took weeks for anything to really happen - indeed, the first
>    sign of any kind of idea for any work was first mentioned at the
>    beginning of January, the day that Nicolas posted these patches
>    for review.  The work was going to be to review these patches.

I don't think the review of precisely those patches was put in any 
contract proposal.  That would have been way too limiting, and a waste 
of your competence.  But that shouldn't matter in this case as the 
problem lays elsewhere as far as the community is concerned.

> 3. As that was going to be the subject of the work, and there was no
>    arrangement in place, I actively avoided reviewing these changes.

That is unacceptable.  You are recognized as the ARM kernel maintainer.  
This role depends on the trust that the community puts in you, and _not_ 
based on any contractual arrangement with any company, be that Linaro or 
any other.

Patches are rejected or accepted in the mainline kernel based on their 
technical merits, period. As the ARM kernel upstream maintainer, you 
cannot use your position to block the merging of some patches based on a 
private matter between you and Linaro.  This is unethical and a direct 
conflict of interest.

And, as I've told you in private many times now, the work resulting in 
those patches is something of the past.  The world has moved on.  Any 
work assigned to you by contract from Linaro would be about something 
else, something new, and not something that used to be new a year ago.  
In fact Linaro is willing to give you money and give you full freedom to 
let you decide to work on anything you want if that improves Linux 
support on ARM.  Why this doesn't sounds good to you is beyond my 
understanding.

Anyway... The fact that quality people did review the MCPM patches 
extensively should be enough for trust to be applied in the decision to 
merge those patches now.  They've been circulated in public for 3 months 
now, they've missed a merge window already, I'm not going to accept they 
miss another one for non technical reasons.

[ legitimate but private issues with no relevance to the community 
  process skipped ]

> Now, I'm currently on holiday.  I'm going to be on holday until after
> mid-April.  I'm not pulling anything until then.  I'm not applying anything
> until then.  I'm not even reading this mailbox - and given current mail
> rates at 300-400 messages per day, I will *not* be reading back over a
> fortnights worth of email.

That is also unacceptable.  Again, you are the appointed ARM kernel 
maintainer.  You have to plan a backup when you are away.  If the load 
is too much, you have to delegate.  They do it for the X86 architecture 
with 3 maintainers despite the fact that the X86 architecture is much 
less active in that regard.

Part of your role as a maintainer is to ensure the community process is 
working well, not to obstruct to it.  And that _independently_ of any 
private engagement you might or might not have with any company.


Nicolas
