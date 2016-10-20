From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Oct 2016 16:50:07 -0700
Subject: [PATCH 2/2] clk: mxs: don't register a clkdev for enet_out
In-Reply-To: <20161020075840.16406-2-u.kleine-koenig@pengutronix.de>
References: <20161020075840.16406-1-u.kleine-koenig@pengutronix.de>
 <20161020075840.16406-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20161020235007.GF26139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20, Uwe Kleine-K?nig wrote:
> The last user is gone in the previous commit. So this can be removed, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

I'm fine if this goes through arm-soc if you want to bunch them
together. Otherwise just resend the patch once the ARM side
merges into some -rc1 and we can remove it in the next next
release.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
