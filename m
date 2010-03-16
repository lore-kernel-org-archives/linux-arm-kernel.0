From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 16 Mar 2010 12:59:55 +0000
Subject: [PATCH 7/8] [ARM] pxa: move ssp into common plat-pxa
In-Reply-To: <771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
	<1268740373-27407-8-git-send-email-eric.y.miao@gmail.com>
	<771cded01003160549t73b30cccr7ba56722c28f013c@mail.gmail.com>
Message-ID: <20100316125955.GB7287@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 08:49:51PM +0800, Haojian Zhuang wrote:

> By the way, I'm still format other patches for share more code between
> pxa2xx-ssp & pxa168-sssp. Since you're updating ssp. The ssp code will
> be different between your git tree and mark's asoc git tree. If my
> patches are merged into asoc git tree, how to sync to your git tree?

> Mark,
> do you have any comments on syncing code?

As I keep say I believe we need to do an early merge of a topic branch
that covers the common stuff into both the PXA and ASoC trees, otherwise
we'll end up with conflicting lines of development and no way to resolve
them until the merge down.
