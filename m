From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Oct 2011 16:50:38 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <alpine.LFD.2.02.1110130932350.17040@xanadu.home>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111013082836.GG21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110130932350.17040@xanadu.home>
Message-ID: <201110131650.39032.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 October 2011, Nicolas Pitre wrote:
> On Thu, 13 Oct 2011, Russell King - ARM Linux wrote:
> > Bypassing maintainers stinks - especially when there are unaddressed
> > comments outstanding.  Nicolas has "simplified" my objections in this
> > request for you to pull - and has completely ignored the problem that
> > it breaks ZBOOT_ROM by deleting the zreladdr definitions on EP93xx
> > with no way for that to be provided.

I've removed it from the arm-soc for-next branch now and won't push it
unless you specifically ask me to.

> I also told you that EP93xx doesn't use ZBOOT_ROM anywhere, and that 
> this was approved by the EP93xx maintainers.
> 
> Furthermore I said that I intended to make ZBOOT_ROM dependent on 
> CONFIG_PHYS_OFFSET, given that PHYS_OFFSEt and zreladdr are intimately 
> related which I also explained previously.  This doesn't have to go in 
> right away though.  But if this is one of your _requirements_, I'd have 
> appreciated you made it clearer instead of letting me to dry without any 
> feedback, especially when I re-re-re-pinged you last week and before.
> 
> So much for having lectured me on proper communication.

There is no point in arguing about who miscommunicated, or in assuming
evil intentions.

The rule for the arm-soc tree is very simple: if someone asks for a
branch to be included and it looks reasonable to me, it goes in.
If else someone has reasonable concerns over the code, it gets
removed again until the concerns are all resolved. Judging what
is reasonable is of course the hard part, but 90% of the time it's
pretty obvious.

	Arnd
