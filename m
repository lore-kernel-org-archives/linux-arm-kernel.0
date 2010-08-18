From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 18 Aug 2010 15:39:40 +0200
Subject: [PATCH 1/5] ARM: add PrimeCell generic DMA to PL022 v9
In-Reply-To: <AANLkTi=vCb8rQu3KPcCv7cP94ovQ_ZFrs7aBjGYtPQmy@mail.gmail.com>
References: <1281095419-15600-1-git-send-email-linus.walleij@stericsson.com>
	<20100817044834.GA27060@angua.secretlab.ca>
	<AANLkTi=vCb8rQu3KPcCv7cP94ovQ_ZFrs7aBjGYtPQmy@mail.gmail.com>
Message-ID: <AANLkTinmYR_N2jv1q7rNR1FWvemXbemkhJBL=_f9eFP0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/18 Grant Likely <grant.likely@secretlab.ca>:

> This patch causes the following build error and warnings. ?The
> warnings are simple init annotation mismatches. ?I haven't dug into
> the error, but I suspect the driver needs to depend on or select
> another config symbol. ?I'm dropping it from my tree.

I'm unable to reproduce this problem in Torvalds' tree and
-next. I'm using the realview, U8500 and U300 defconfigs with and
without the DMAengine, no difference, totally silent.

What kind of configuration are you building this on?

Yours
Linus Walleij
