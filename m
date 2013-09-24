From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Sep 2013 12:10:17 -0700
Subject: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924191017.GH19754@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24, Uwe Kleine-K??nig wrote:
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. So
> all symbols that select at least two of these symbols can be simplified.
> 
> For imx, omap2 and ux500 some rearrangements were necessary before the
> simplification.
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

For MSM:

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
