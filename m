From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Oct 2011 13:20:24 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111010103635.GA2451@mudshark.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110072251.40028.arnd@arndb.de>
	<20111010103635.GA2451@mudshark.cambridge.arm.com>
Message-ID: <201110101320.24457.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 October 2011, Will Deacon wrote:
> > I can certainly fix up the conflicts, but my feeling is that there is
> > something wrong on your side and one of the two branches contains
> > stuff from a stale version of Russell's tree.
> 
> It looks like both of the branches [cpu-mapping and debug-ll] may be out of
> date now. I agree that fixing up the conflicts isn't the way to go here, but
> I'm unsure what to use as my base. I depend on patches that aren't in
> Russell's devel-stable branch but are in his for-next branch.
> 
> The only things I can think of are either:
> 
>  - Wait until everything has settled down, then rebase onto Russell's
>    for-linus branch. This has the disadvantage that conflicts and build
>    breakages won't be detected until very late.
> 
>  - Wait until the dependencies are in mainline, then rebase against that.
>    Disadvantage is that it then takes twice as long to get code upstream.
> 
>  - Send another pull request against an unstable branch and hope it doesn't
>    change. Disadvantage being that we have to keep repeating pull requests
>    against a moving target.
> 
> I'm not especially fond of any of those though...
> 
> Do you have any other ideas?

I think the best solution would be to ask Russell to put all the dependencies
into a non-rebasing branch and publish that, or to alternatively merge your
patches through his tree instead, with my Ack.

Both of these will also have to wait for a few more days until Russell
is back online.

Can you check if the devel-stable branch in his tree already contains the
dependencies?

	Arnd
