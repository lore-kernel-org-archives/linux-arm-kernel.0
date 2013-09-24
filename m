From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 24 Sep 2013 14:27:18 -0500
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380050838.32297.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-24 at 19:41 +0200, Uwe Kleine-K?nig wrote:
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
> 
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
> 
> Signed-off-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
> ---
For SOCFPGA:

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
