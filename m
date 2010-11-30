From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 15:32:47 +0100
Subject: [PATCH] make mc13783 code generic
In-Reply-To: <1291110118.3235.27.camel@realization>
References: <AANLkTimfDHRXZjB5=Ld9YSFzqh-hVWUTy-TQFV=GEaGA@mail.gmail.com>
	<1291110118.3235.27.camel@realization>
Message-ID: <20101130143247.GI20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yong, hello Alberto,

On Tue, Nov 30, 2010 at 10:41:58AM +0100, Alberto Panizzo wrote:
> PS: ./scripts/get_maintainer.pl said to cc all these guys:
> 
> Liam Girdwood <lrg@slimlogic.co.uk>
> Mark Brown <broonie@opensource.wolfsonmicro.com>
> Samuel Ortiz <sameo@linux.intel.com>
> Haojian Zhuang <haojian.zhuang@marvell.com>
> Linus Walleij <linus.walleij@stericsson.com>
> Alberto Panizzo <maramaopercheseimorto@gmail.com>
> "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>
> Axel Lin <axel.lin@gmail.com>
> Andrew Morton <akpm@linux-foundation.org>
> "Philippe R?tornaz" <philippe.retornaz@epfl.ch>
> linux-kernel at vger.kernel.org
> 
> Please, use always this script to decide who have to be cc'ed by default
> sending patches.
No, please don't.  Better use your common sense.  get_maintainer.pl is a
hint at best.  E.g. Axel Lin only shows up in the list, because he
touched several other regulator drivers and drivers/regulator/Makefile.
I doubt that this is enough to imply interest.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
