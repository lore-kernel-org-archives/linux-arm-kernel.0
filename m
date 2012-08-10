From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Aug 2012 11:22:20 +0800
Subject: [PATCH] ARM: imx/iomux-v3: allow pad_list to be const
In-Reply-To: <1344527835-32567-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344527835-32567-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120810032217.GF19617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 05:57:15PM +0200, Uwe Kleine-K?nig wrote:
> Also fix all machine files to make use of it and while at it also make
> the pad lists __init_const.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> well, iomux-v3 is dying so I don't know how welcome this patch is.
> 
For me, it's not so welcomed at this point, as I have seen it's
patching a bunch of imx5 board files that are scheduled for removal
for this cycle.

-- 
Regards,
Shawn
