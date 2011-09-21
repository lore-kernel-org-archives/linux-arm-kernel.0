From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Sep 2011 14:10:52 +0100
Subject: [PATCH] spi: Fix builderror in spi-pl022.c
In-Reply-To: <CACRpkdbsUMCvBofKjExiB2wCbK9CwpcXr5xmShJ4SHEGAAH4Bw@mail.gmail.com>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
	<CACRpkdb=Bt2j4iMV5NJHmPG8wDi6__CRD6kn_KOoaQ1R6uwrWQ@mail.gmail.com>
	<CACRpkdbsUMCvBofKjExiB2wCbK9CwpcXr5xmShJ4SHEGAAH4Bw@mail.gmail.com>
Message-ID: <20110921131052.GG17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:45:41PM +0200, Linus Walleij wrote:
> On Mon, Sep 5, 2011 at 2:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sun, Aug 28, 2011 at 9:26 PM, Peter Huewe <peterhuewe@gmx.de> wrote:
> >
> >> This patch fixes a build error, introduced by commit (67fc8b9f, "PM: add
> >> runtime PM support to core Primecell driver") which unfortunately was a little
> >> bit incomplete and did contain a typo (11 instead of 22).
> >> I'm not sure how this patch could have been tested back then, if it
> >> doesn't even compile ;)
> >
> > Grant can you please apply this patch? Right now linux-next is
> > breaking because of this missing patch...
> 
> Ping on this... ignore if it's been picked already.

Isn't it already fixed?  I've had this in my tree for quite some time
(since 5th September) which should also be in linux-next.

b21c57c ARM: 7079/1: spi: Fix builderror in spi-pl022.c
612f2eb PM: add runtime PM support to MMCI
67fc8b9 PM: add runtime PM support to core Primecell driver
