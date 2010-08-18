From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 18 Aug 2010 11:18:00 +0200
Subject: [PATCH 1/5] ARM: add PrimeCell generic DMA to PL022 v9
In-Reply-To: <AANLkTi=vCb8rQu3KPcCv7cP94ovQ_ZFrs7aBjGYtPQmy@mail.gmail.com>
References: <1281095419-15600-1-git-send-email-linus.walleij@stericsson.com>
	<20100817044834.GA27060@angua.secretlab.ca>
	<AANLkTi=vCb8rQu3KPcCv7cP94ovQ_ZFrs7aBjGYtPQmy@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0267540DE4@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Grant]

> This patch causes the following build error and warnings.  The
> warnings are simple init annotation mismatches.  I haven't dug into
> the error, but I suspect the driver needs to depend on or select
> another config symbol.  I'm dropping it from my tree.

OK I'll cook up a new one with all the fixes and fix this stuff
too....

Yours,
Linus Walleij
