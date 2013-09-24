From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Sep 2013 11:08:15 -0700
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924180815.GA8949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [130924 10:50]:
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
> 
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

For the omap changes:

Acked-by: Tony Lindgren <tony@atomide.com>
