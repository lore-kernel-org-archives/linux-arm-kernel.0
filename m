From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Oct 2011 14:32:46 +0100
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <201110101320.24457.arnd@arndb.de>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<201110072251.40028.arnd@arndb.de>
	<20111010103635.GA2451@mudshark.cambridge.arm.com>
	<201110101320.24457.arnd@arndb.de>
Message-ID: <20111010133246.GG2451@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 12:20:24PM +0100, Arnd Bergmann wrote:
> On Monday 10 October 2011, Will Deacon wrote:
> > Do you have any other ideas?
> 
> I think the best solution would be to ask Russell to put all the dependencies
> into a non-rebasing branch and publish that, or to alternatively merge your
> patches through his tree instead, with my Ack.

I don't think asking Russell to maintain a stable branch for each series
scales very well if multiple people are doing cross-platform work at the
same time. If he's happy merging platform code via his tree, then I'd prefer
to go down that route. In this case, it might make sense to try and catch
conflicts between his tree and arm-soc before they hit Linus (I guess -next
will take care of this?).

> Both of these will also have to wait for a few more days until Russell
> is back online.

Ok, I wasn't aware that we was away.

> Can you check if the devel-stable branch in his tree already contains the
> dependencies?

I just had a quick look and I can't seem them outside of the unstable for-next
branch.

Cheers,

Will
