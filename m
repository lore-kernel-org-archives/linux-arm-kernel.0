From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 16:09:22 +0100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <87bna92c5b.fsf@free-electrons.com>
References: <20151202111244.b7ee49ee06b4a95e407e740d@kernel.org>
 <2428665.BrOON4cELy@wuerfel> <87bna92c5b.fsf@free-electrons.com>
Message-ID: <241533090.9LSHZ5gDBE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 14:49:52 Gregory CLEMENT wrote:
> 
> > least initially. The conflict will go away once it's tested sufficiently and
> > I'm pulling it back.
> 
> By the way, when you will pull our tree, we will still have it our own
> mvebu/for-next branch. Will git managed to automagically resolve the
> conflict by getting the resolution you will do in your branch?

Yes, that should be fine, unless you resolve the same conflict differently.

> A another solution could be to have a separate patch for the
> arch/arm/Kconfig file that you keep in arm-soc.

No, I don't think that will be necessary.

	Arnd 
