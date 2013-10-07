From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 10:42:20 -0700
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380618536-12823-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380618536-12823-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131007174220.GA17592@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:08:56AM +0200, Uwe Kleine-K?nig wrote:
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
> 
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I didn't check, but Linus Walleij pointed out that the ux500 changes might
> conflict with other stuff in the ARM SoC tree. I assume you'll tell me if you
> have problems that are not easy to resolve.

No conflict so far, so I've applied this in next/cleanup.


-Olof
