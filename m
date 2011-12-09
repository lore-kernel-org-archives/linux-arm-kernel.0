From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Dec 2011 13:55:16 +0000
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <20111209092300.GR4585@pengutronix.de>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <4693507.K6tP4YDUh2@wuerfel> <20111209092300.GR4585@pengutronix.de>
Message-ID: <201112091355.16720.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 December 2011, Uwe Kleine-K?nig wrote:
> On Thu, Dec 08, 2011 at 11:55:53PM +0100, Arnd Bergmann wrote:
> > On Thursday 08 December 2011 23:40:57 Uwe Kleine-K?nig wrote:
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Note that there is no support yet for efm32 in mainline, so ARCH_EFM32
> > > isn't defined.
> > 
> > Since the platform is not yet part of the architecture, it will have
> > to use device tree based probing when it gets added. I would suggest
> > only merging drivers for it that can deal with this and do not rely
> > on platform_data.
>
> I feared you will say that. These machines have at most 4MiB of RAM.
> I'll have to evaluate if dt is too heavy for them.

What's the state of the platform code? Is this based on Catalin's
Cortex-M3 tree? I've heard a few people express interest in getting
various M3 based SoCs supported mainline and I think that would
be a good idea, but I would also expect that device tree is one
of the lesser problems here.

	Arnd
