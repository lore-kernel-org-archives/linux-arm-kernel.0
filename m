From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Sep 2014 14:10:51 +0200
Subject: [PATCH] ARM: efm32: drop selecting NO_DMA
In-Reply-To: <1411640056.7866.5.camel@x220>
References: <1411585151.19525.29.camel@x220>
 <1411640056.7866.5.camel@x220>
Message-ID: <20140925121051.GM3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On Thu, Sep 25, 2014 at 12:14:16PM +0200, Paul Bolle wrote:
> On Wed, 2014-09-24 at 20:59 +0200, Paul Bolle wrote:
> > Actually, the only difference I found in the .config file was that after
> > this patch the .config file contained
> >     CONFIG_ARCH_EFM32=y
> > 
> > I have no idea why. Did I botch my test?
Looking at the patch that introduced the NO_DMA select I think I just
copied it from somewhere[1] without questioning it. It seems the symbol
already didn't exist when efm32 hit mainline in
6d85e2b0b6bed6ae7070426d5e43174c593e075c.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

[1] probably Catalin's 2.6.33 that introduced v7-M support initially.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
