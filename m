From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 23 Sep 2010 16:00:31 +0300
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <AANLkTi=LHxCHrAvWgscZDeHUZ3LfVjwARSf60DZYV8gL@mail.gmail.com>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikuKC2n488ZNAeSr83p9cju2ZQCGU1W_FXqgzVy@mail.gmail.com>
	<1284971979.2286.46.camel@localhost>
	<AANLkTi=LHxCHrAvWgscZDeHUZ3LfVjwARSf60DZYV8gL@mail.gmail.com>
Message-ID: <1285246831.29268.118.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-22 at 10:10 +0200, Linus Walleij wrote:
> 2010/9/20 Artem Bityutskiy <dedekind1@gmail.com>:
> > On Tue, 2010-09-14 at 10:52 +0200, Linus Walleij wrote:
> >> 2010/9/13 Linus Walleij <linus.walleij@stericsson.com>:
> >>
> >> > This is the same driver submitted by ST Micros SPEAr team but
> >> > generalized and tested on the ST-Ericsson U300. It probably
> >> > easily works on the NHK8815 too.
> >>
> >> David if this one looks OK then can you merge both patches through
> >> the MTD tree?
> >
> > I've pushed both patches to my l2-mtd-2.6.git / master, without signing
> > this off myself.
> 
> Thanks Artem, are you integrating MTD to Linus (Torvalds)?

Not me, dwmw2 should pick patches from my tree.

> This git is not part of linux-next right?

Right.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
