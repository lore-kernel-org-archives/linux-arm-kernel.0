From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Sep 2012 07:30:08 +0000
Subject: [GIT PULL V3 1/5] ARM: Kirkwood: address decoding change for v3.7
In-Reply-To: <20120922052904.GC32245@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921194141.GV5469@titan.lakedaemon.net>
 <20120922052904.GC32245@quad.lixom.net>
Message-ID: <201209220730.08562.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 September 2012, Olof Johansson wrote:
> This branch has pretty massive merge conflicts with cleanup/io-pci and other
> branches, in particular due to the large number of conflicting cleanup patches.
> 
> It'd be better to focus on just the address decoding pieces in this branch, and
> move the cleanups to a separate branch. Given the state of affairs w.r.t.
> conflicts for the cleanups, saving those for 3.8 might be a better idea.
> 
> I mentioned in one of the other comments to a patch in this series that
> I was going to pull this in as staging/* and get linux-next coverage,
> but these conflicts are more than what I want to deal with now -- so
> I'll hold off pulling these in after all.

I think the branch is needed though, to avoid lots of build warnings
when the changes to asm/io.h from Russell's tree hit mainline. I did similar
patches for most of the other platforms but left out the ones that I knew
Thomas was already working on.

	Arnd
