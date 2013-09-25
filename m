From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 25 Sep 2013 11:28:56 +0100
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380104936.7211.3.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-24 at 18:41 +0100, Uwe Kleine-K?nig wrote:
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
> 
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
>  arch/arm/mach-vexpress/Kconfig |  2 --

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
