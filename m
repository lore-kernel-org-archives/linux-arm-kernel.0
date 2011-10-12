From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Oct 2011 18:35:23 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111012172925.GD21648@n2100.arm.linux.org.uk>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111011150915.GE23188@mudshark.cambridge.arm.com>
	<20111011184821.GA11839@mudshark.cambridge.arm.com>
	<2414781.rlNqTThJUN@wuerfel>
	<20111012172925.GD21648@n2100.arm.linux.org.uk>
Message-ID: <20111012173523.GB12865@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Oct 12, 2011 at 06:29:25PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 11, 2011 at 09:25:19PM +0200, Arnd Bergmann wrote:
> > Russell, would be mind putting the 8 patches that Will listed above
> > into the devel-stable or some other non-rebasing branch so we can
> > rebase Will's patches on top of that?
> > 
> > Alternatively, if you prefer you could also throw them out of your
> > tree so I can send them to Linus, or you could pull the two patch
> > series from Will into your arm tree so I can drop them completely.
> 
> At this point in the game (which I guess is that the merge window is
> very likely going to open this evening), I'm minded to just say no, my
> tree is now frozen, and that's that - especially as there's a bunch of
> _horrible_ merges involved in rebuilding that stuff now.
> 
> Especially as its going to take me a few days before I start looking
> at touching my git tree as I'll be sorting through the email backlog.

OK, that's understandable. Does this mean that your for-next branch is what
will be going to Linus when the merge window opens? If so, I can rebase onto
that now that it's frozen and Arnd can pull in the platform bits to arm-soc.

Cheers,

Will
